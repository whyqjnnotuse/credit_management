<script setup>
import { useUserStore } from '@/stores'
import { useRouter } from 'vue-router'
import { ref, reactive, onMounted, watch, nextTick } from 'vue'
import { Edit, Delete } from '@element-plus/icons-vue'
import { formatTime, formatTime2 } from '@/utils/format.js'
import { GetListService, DelbatchListService, DelService, EditOrAddService, MergeService } from '@/api/unpaid'
const tableData = ref([])
const loading = ref(false)
const form = ref({})
const formRef = ref(null);
const dialogFormVisible = ref(false)
const multipleSelection = ref([])
const user = reactive(localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {})
const router = useRouter()
const store = useUserStore()
const title = ref('')
// 总条数
const total = ref(0)
const params = ref({
  pageNum: 1,
  pageSize: 5,
  name: ''
})

// 获取列表
const getUnpaidList = async () => {
  try {
    loading.value = true
    // console.log('params.value')
    // console.log(params.value)
    const res = await GetListService(params.value)
    console.log('res.data.data')
    console.log(res.data.data)

    if (res.data && res.data.data) {
      tableData.value = res.data.data.records
      total.value = res.data.data.total
    } else {
      console.error('数据格式不正确', res.data);
    }
    loading.value = false
  } catch (error) {
    console.error('获取数据失败', error);
  } finally {
    loading.value = false
  }
}

// 重置
const onReset = () => {
  params.value.pageNum = 1
  params.value.username = ''
  getUnpaidList()
}

// 搜索
const onSearch = () => {
  console.log('搜索');
  params.value.pageNum = 1
  getUnpaidList()
}

// 获取合并表格
const merge = async () =>{
  await ElMessageBox.confirm('在获取未交的档案前请确保此表格为空', '温馨提示', {
    type: 'warning',
    confirmButtonText: '确认',
    cancelButtonText: '取消'
  })
  await MergeService() 
  ElMessage.success('获取成功')
  getUnpaidList()

}


const editManage = async (row) => {
  title.value = '编辑'
  dialogFormVisible.value = true
  const formattedRow = {
    ...row,
    loanDate: formatTime2(row.loanDate),
    handoverTime: formatTime2(row.handoverTime),
    lastDate: formatTime2(row.lastDate)
  };
  form.value = { ...formattedRow };
  console.log(form.value)
  console.log(1111);
}
const save = async () => {
  console.log('保存')
      // Submit form
      await EditOrAddService(form.value)
      ElMessage.success('更新成功')
      getUnpaidList()
      dialogFormVisible.value = false;
}
const delBatch = async () => {
  console.log('批量删除')
  console.log(multipleSelection.value.length);
  if (!multipleSelection.value.length) {
    ElMessage.error("请选择需要删除的数据")
    return
  }
  await ElMessageBox.confirm('你确认批量删除这些信息吗？', '温馨提示', {
    type: 'warning',
    confirmButtonText: '确认',
    cancelButtonText: '取消'
  })
  let ids = multipleSelection.value?.map(v => v.userCode)  // [{}, {}, {}] => [1,2,3]
  await DelbatchListService(ids)
  ElMessage({ type: 'success', message: '批量删除成功' })
  getUnpaidList()
}
const deleteManage = async (row) => {
  await ElMessageBox.confirm('你确认删除该信息吗？', '温馨提示', {
    type: 'warning',
    confirmButtonText: '确认',
    cancelButtonText: '取消'
  })
  await DelService(row.userCode)
  ElMessage({ type: 'success', message: '删除成功' })
  getUnpaidList()
  console.log('删除')
}

// 选择项
const handleSelectionChange = (val) => {
  console.log(val)
  multipleSelection.value = val
}
// 处理分页逻辑
const handleSizeChange = (pageSize) => {
  // console.log('每页条数变化了' + size)
  // 只要每页条数变化了，访问的本页面就无意义了，要回到第一页
  params.value.pageNum = 1
  params.value.pageSize = pageSize
  // 基于当前的最新页和码数更新
  getUnpaidList()
}
const handleCurrentChange = (pageNum) => {
  // console.log('页码变化了' + page)
  // 基于最新的当前页渲染数据
  params.value.pageNum = pageNum
  getUnpaidList()
}
// 上传文件
const handleSuccess = () => {
  ElMessage.success('上传成功')
}

onMounted(()=>{
  getUnpaidList()
})
</script>
<template>
    <el-card shadow="always" class="card">
      <!-- 表单 -->
      <el-form inline>
        <el-form-item label="用户">
        <el-input v-model="params.username" placeholder="请输入用户"></el-input>
      </el-form-item>
        <el-form-item>
        <el-button @click="onSearch" type="primary">搜索</el-button>
        <el-button @click="onReset">重置</el-button>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="merge">合并表格</el-button>
      </el-form-item>
      <el-form-item>
        <el-button type="danger" slot="reference" @click="delBatch">批量删除 <i
            class="el-icon-remove-outline"></i></el-button>
      </el-form-item>
    </el-form>
    <!-- 表格 -->
    <el-table :data="tableData" border stripe :header-cell-class-name="'headerBg'"
      @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="username" label="客户姓名" fixed></el-table-column>
      <el-table-column prop="userCode" label="客户代码" fixed></el-table-column>
      <el-table-column prop="creditRecipients" label="信贷对象"></el-table-column>
      <el-table-column prop="operationType" label="业务品种"></el-table-column>
      <el-table-column prop="loanId" label="借款合同编号"></el-table-column>
      <el-table-column prop="archiveLocation" label="档案位置"></el-table-column>
      <el-table-column prop="contractId" label="借款凭证编号"></el-table-column>
      <el-table-column prop="handoverTime" label="档案移交时间">
        <template #default="{ row }">
          {{ formatTime(row.handoverTime) }}
        </template>
      </el-table-column>
      <el-table-column prop="lendingInstitution" label="放贷机构"></el-table-column>
      <el-table-column prop="loanAmount" label="借款金额"></el-table-column>
      <el-table-column prop="loanDate" label="借款日期">
        <template #default="{ row }">
          {{ formatTime(row.loanDate) }}
        </template>
      </el-table-column>
      <el-table-column prop="lastData" label="到期日期">
        <template #default="{ row }">
          {{ formatTime(row.lastDate) }}
        </template>
      </el-table-column>
      <el-table-column prop="file" label="档案材料" width="150">
        <template #default="{ row }">
          <el-upload v-model:file-list="fileList" class="upload-demo"
            action="https://run.mocky.io/v3/9d059bf9-4660-45f2-925d-ce80ad6c4d15" multiple 
            :on-remove="handleRemove" :before-remove="beforeRemove" :limit="3":on-success="handleSuccess" >
            <el-button type="primary">上传文件</el-button>
            <template #tip>
              <div class="el-upload__tip">
              </div>
            </template>
          </el-upload>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="110">
        <template #default="{ row, $index }">
          <el-button type="primary" :icon="Edit" circle plain @click="editManage(row, $index)"></el-button>
          <el-button type="danger" :icon="Delete" circle plain @click="deleteManage(row, $index)"></el-button>
        </template>
      </el-table-column>
    </el-table>
        <!-- 分页区域 -->
        <el-pagination v-model:current-page="params.pageNum" v-model:page-size="params.pageSize" :page-sizes="[1, 2, 5]"
      background layout="total, sizes, prev, pager, next, jumper" :total="total" @size-change="handleSizeChange"
      @current-change="handleCurrentChange" style="margin-top: 25px; justify-content: flex-end" />
    <!-- 对话框 -->
    <el-dialog :title="title" v-model="dialogFormVisible" width="40%" :before-close="closeDialog"
      :close-on-click-modal="false">
      <el-form :model="form" ref="formRef" label-width="120px" size="small" style="width: 80%; margin: 0 auto">
        <el-form-item prop="username" label="客户姓名">
          <el-input v-model="form.username" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="userCode" label="客户代码">
          <el-input v-model="form.userCode" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="creditRecipients" label="信贷对象">
          <el-input v-model="form.creditRecipients" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="operationType" label="业务品种">
          <el-input v-model="form.operationType" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="loanId" label="借款合同编号">
          <el-input v-model="form.loanId" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="archiveLocation" label="档案位置">
          <el-input v-model="form.archiveLocation" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="contractId" label="借款凭证编号">
          <el-input v-model="form.contractId" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="handoverTime" label="档案移交时间">
          <el-date-picker v-model="form.handoverTime" type="date" placeholder="选择日期"></el-date-picker>
        </el-form-item>
        <el-form-item prop="lendingInstitution" label="放贷机构">
          <el-input v-model="form.lendingInstitution" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="loanAmount" label="借款金额">
          <el-input v-model="form.loanAmount" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="loanDate" label="借款日期">
          <el-date-picker v-model="form.loanDate" type="date" placeholder="选择日期"></el-date-picker>
        </el-form-item>
        <el-form-item prop="lastData" label="到期日期">
          <el-date-picker v-model="form.lastData" type="date" placeholder="选择日期"></el-date-picker>
        </el-form-item>
        <!-- <el-form-item prop="file" label="">
          <el-upload action="http://localhost:9090/file/upload" ref="file" :on-success="handleFileUploadSuccess">
            <el-button size="small" type="primary">点击上传</el-button>
          </el-upload>
        </el-form-item> -->
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>
  </el-card>
</template>

<style  scoped>
.card {
  margin: 20px;
}
</style>

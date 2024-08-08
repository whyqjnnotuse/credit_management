<script setup>
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
const title = ref('')
// const name = ref('')
// 总条数
const total = ref(0)
const params = ref({
  pageNum: 1,
  pageSize: 5,
  userCode: null
})

// 获取列表
const getUnpaidList = async () => {
  try {
    loading.value = true
    const res = await GetListService(params.value)
    if (res.data && res.data.data) {

      const records = res.data.data.records
      records.forEach(item => {
        item.fileList = [];
        if (item.file) {
          const fileArr = JSON.parse(item.file);
          fileArr.forEach(fileItem => {
            item.fileList.push({
              name: fileItem.name,
              url: fileItem.url
            })
          })
        }
      })
      tableData.value = records
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
  params.value.userCode = null
  getUnpaidList()
}

// 搜索
const onSearch = () => {
  console.log('搜索');
  params.value.pageNum = 1
  getUnpaidList()
}

// 获取合并表格
const merge = async () => {
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
}
const save = async () => {
  console.log('保存')
  // Submit form
  form.value.file = JSON.stringify(form.value.file);
  await EditOrAddService(form.value)
  ElMessage.success('更新成功')
  getUnpaidList()
  dialogFormVisible.value = false;
}
const delBatch = async () => {
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
  await DelService(parseInt(row.userCode))
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
const handleSuccess = (res, file, fileList) => {
  console.log(file);
  console.log('数组', fileList);
  form.value.file = [];
  fileList.forEach((item) => {
    form.value.file.push({
      name: item.name,
      url: item.response,
    })
  })

  ElMessage.success('上传成功');
}

onMounted(() => {
  getUnpaidList()
})
</script>
<template>
  <el-card shadow="always" class="card">
    <!-- 表单 -->
    <el-form inline>
      <el-form-item label="客户代码">
        <el-input v-model.number="params.userCode" placeholder="请输入客户代码"></el-input>
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
      <el-table-column label="档案管理">
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
      </el-table-column>
      <el-table-column label="档案入库">
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
            <el-upload v-model:file-list="row.fileList" class="upload-demo" action="http://localhost:9090/file/upload"
              multiple :on-remove="handleRemove" :before-remove="beforeRemove" :on-success="handleSuccess"
              show-file-list>
              <!-- <el-button type="primary" size="small">上传文件</el-button> -->
              <template #tip>
                <div class="el-upload__tip">
                </div>
              </template>
            </el-upload>
          </template>
        </el-table-column>
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
          <el-input v-model.number="form.userCode" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="creditRecipients" label="信贷对象">
          <el-input v-model="form.creditRecipients" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="operationType" label="业务品种">
          <el-input v-model="form.operationType" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="loanId" label="借款合同编号">
          <el-input v-model.number="form.loanId" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="archiveLocation" label="档案位置">
          <el-input v-model="form.archiveLocation" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="contractId" label="借款凭证编号">
          <el-input v-model.number="form.contractId" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="handoverTime" label="档案移交时间">
          <el-date-picker v-model="form.handoverTime" type="date" placeholder="选择日期"></el-date-picker>
        </el-form-item>
        <el-form-item prop="lendingInstitution" label="放贷机构">
          <el-input v-model="form.lendingInstitution" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="loanAmount" label="借款金额">
          <el-input v-model.number="form.loanAmount" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="loanDate" label="借款日期">
          <el-date-picker v-model="form.loanDate" type="date" placeholder="选择日期"></el-date-picker>
        </el-form-item>
        <el-form-item prop="lastDate" label="到期日期">
          <el-date-picker v-model="form.lastDate" type="date" placeholder="选择日期"></el-date-picker>
        </el-form-item>
        <el-form-item prop="file" label="文件">
          <el-upload v-model:file-list="form.fileList" class="upload-demo" action="http://localhost:9090/file/upload"
            multiple :on-remove="handleRemove" :before-remove="beforeRemove" :on-success="handleSuccess"
            show-file-list>
            <el-button type="primary" size="small">上传文件</el-button>
            <template #tip>
              <div class="el-upload__tip">
              </div>
            </template>
          </el-upload>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="dialogFormVisible = false">取 消</el-button>
          <el-button type="primary" @click="save">确 定</el-button>
        </div>
      </template>
    </el-dialog>
  </el-card>
</template>

<style scoped>
.card {
  margin: 20px;
}
</style>

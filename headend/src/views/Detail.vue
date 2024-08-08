<script setup>
import { ref, reactive, onMounted, watch, nextTick } from 'vue'
import { Edit, Delete } from '@element-plus/icons-vue'
import { formatTime, formatTime2 } from '@/utils/format.js'
import { GetListService, DelbatchListService, DelService, EditOrAddService, ExportService, ImportService } from '@/api/detail'

const tableData = ref([])
const upload = ref(null)
const loading = ref(false)
const form = ref({})
const formRef = ref(null);
const dialogFormVisible = ref(false)
const multipleSelection = ref([])
const user = ref(localStorage.getItem("credit_user") ? JSON.parse(localStorage.getItem("credit_user")) : {})
const credit = ref(localStorage.getItem("credit") ? JSON.parse(localStorage.getItem("credit")) : {})
const title = ref('')
const uploadRef = ref(null)
// 总条数
const total = ref(0)
const params = ref({
  pageNum: 1,
  pageSize: 5,
  clientName: '',
  userCode: null,
  loanContractId: null,
  loanVoucherId: null,
  businessVariety: '',
  lendingInstitution: ''
})
// 表单验证规则
const rules = {
  lendingInstitution: [
    { required: true, message: '请输入放款机构', trigger: 'blur' }
  ],
  clientName: [
    { required: true, message: '请输入客户名称', trigger: 'blur' },
    { min: 3, max: 10, message: '长度在 3 到 10 个字符', trigger: 'blur' }
  ],
  userCode: [
    { required: true, message: '请输入客户代码', trigger: 'blur' },
    // { type: 'number',min: 3, max: 20, message: '客户代码必须为数字', trigger: 'blur' }
  ],
  loanContractId: [
    { required: true, message: '请输入借款合同编号', trigger: 'blur' },
    // { type: 'number',min: 3, max: 20, message: '借款合同编号必须为数字', trigger: 'blur' }
  ],
  loanVoucherId: [
    { required: true, message: '请输入借款凭证编号', trigger: 'blur' },
    // { type: 'number',min: 3, max: 20, message: '借款凭证编号必须为数字', trigger: 'blur' }
  ],
  businessVariety: [
    { required: true, message: '请输入业务品种', trigger: 'blur' }
  ],
  loanAmount: [
    { required: true, message: '请输入借款金额', trigger: 'blur' },
    // { type: 'number', message: '借款金额必须为数字' }
  ],
  loanDate: [
    { required: true, message: '请选择借款日期', trigger: 'blur' }
  ],
  lastDate: [
    { required: true, message: '请选择到期日期', trigger: 'blur' }
  ]
}

// 获取列表
const getDetailList = async () => {
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

      // tableData.fileList 不存在
      // records.forEach(item => {
      //   item.fileList = [];
      //   const files = item.file;
      //   const filesArr = [];
      //   if (files && files.indexOf(',') != -1) {
      //     filesArr = files.split(',');
      //   } else {
      //     filesArr.push(files);
      //   }

      //   filesArr.forEach(file => {
      //     if (file) {
      //       const fileNameArr = file.split('/');
      //       item.fileList.push({
      //         name: fileNameArr[fileNameArr.length - 1],
      //         url: file,
      //       })
      //     }
      //   })
      // })

      tableData.value = records;
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
  params.value.clientName = ''
  params.value.userCode = ''
  params.value.loanContractId = ''
  params.value.loanVoucherId = ''
  params.value.lendingInstitution = ''
  params.value.businessVariety = ''
  getDetailList()
}

// 搜索
const onSearch = () => {
  console.log('搜索');
  params.value.pageNum = 1
  getDetailList()
}

const addManage = () => {
  title.value = '添加'
  form.value = {}
  dialogFormVisible.value = true
  console.log('add')
}

const editManage = async (row) => {
  title.value = '编辑'
  dialogFormVisible.value = true
  const formattedRow = {
    ...row,
    loanDate: formatTime2(row.loanDate),
    lastDate: formatTime2(row.lastDate)
  };
  form.value = { ...formattedRow };
  // console.log(form.value)
  // console.log(1111);
}
const save = () => {
  console.log('保存')
  form.value.file = JSON.stringify(form.value.file);
  formRef.value.validate(async (valid) => {
    if (valid) {
      // Submit form
      await EditOrAddService(form.value)
      ElMessage.success('更新成功')
      getDetailList()
      dialogFormVisible.value = false;
      formRef.value.resetFields();
    } else {
      console.log('error submit!!');
      return false;
    }
  });
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
  getDetailList()
}
const deleteManage = async (row) => {
  await ElMessageBox.confirm('你确认删除该信息吗？', '温馨提示', {
    type: 'warning',
    confirmButtonText: '确认',
    cancelButtonText: '取消'
  })
  await DelService(row.userCode)
  ElMessage({ type: 'success', message: '删除成功' })
  getDetailList()
  console.log('删除')
}
// 导出
const exp = () => {
  window.open("http://localhost:9090/detail/export")
}
// 选择项
const handleSelectionChange = (val) => {
  // console.log(val)
  multipleSelection.value = val
}
// 处理分页逻辑
const handleSizeChange = (pageSize) => {
  // console.log('每页条数变化了' + size)
  // 只要每页条数变化了，访问的本页面就无意义了，要回到第一页
  params.value.pageNum = 1
  params.value.pageSize = pageSize
  // 基于当前的最新页和码数更新
  getDetailList()
}
const handleCurrentChange = (pageNum) => {
  // console.log('页码变化了' + page)
  // 基于最新的当前页渲染数据
  params.value.pageNum = pageNum
  getDetailList()
}

onMounted(() => {
  getDetailList()
})
// 关闭对话框
const cancel = () => {
  dialogFormVisible.value = false;
  formRef.value.resetFields();
}

const closeDialog = () => {
  dialogFormVisible.value = false;
  formRef.value.resetFields();
}
// 导入
const handleExcelImportSuccess = async () => {
  // await ImportService()
  console.log('开始导入');
  ElMessage.success('导入成功')
  getDetailList()

}
// 上传文件
const beforeRemove = () => {
  // ElMessage.error('上传失败')
  console.log('删除之前');
}
const handleRemove = () => {
  // ElMessage.error('上传失败')
  console.log('删除之前');
}
const handlePreview = (file) => {
  // ElMessage.error('上传失败')
  // window.open(url)
  
  console.log('下载');
  console.log(file.uid);
  window.open(`http://localhost:9090/file/${file.uid}`)
}

const errorMessage = () => {
  ElMessage.error('上传失败，请联系管理员')
}

const handleSuccess = (res, file, fileList, index) => {
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
</script>

<template>
  <el-card shadow="always" class="card">
    <el-form inline>
      <el-form-item label="客户名称">
        <el-input v-model="params.clientName" placeholder="请输入客户名称"></el-input>
      </el-form-item>
      <el-form-item label="客户代码">
        <el-input v-model.number="params.userCode" placeholder="请输入客户代码"></el-input>
      </el-form-item>
      <el-form-item label="借款合同编号">
        <el-input v-model.number="params.loanContractId" placeholder="请输入借款合同编号"></el-input>
      </el-form-item>
      <el-form-item label="借款凭证编号">
        <el-input v-model.number="params.loanVoucherId" placeholder="请输入借款凭证编号"></el-input>
      </el-form-item>
      <el-form-item label="放款机构">
        <el-input v-model="params.lendingInstitution" placeholder="请输入放款机构名称"></el-input>
      </el-form-item>
      <el-form-item label="业务品种">
        <!-- <el-select v-model="params.businessVariety" style="width:105px">
          <el-option label="二手房贷款1" value="二手房贷款1"></el-option>
          <el-option label="二手房贷款2" value="二手房贷款2"></el-option>
        </el-select> -->
        <el-input v-model="params.businessVariety" placeholder="请输入业务品种"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button @click="onSearch" type="primary">搜索</el-button>
        <el-button @click="onReset">重置</el-button>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="addManage">添加客户</el-button>
      </el-form-item>
      <el-form-item>
        <el-button type="danger" slot="reference" @click="delBatch">批量删除 <i
            class="el-icon-remove-outline"></i></el-button>
      </el-form-item>
      <el-form-item>
        <!-- :before-upload="beforeUpload" :on-error="error" action="http://localhost:9090/detail/import"-->
        <el-upload action="http://localhost:9090/detail/import" ref="uploadRef" :show-file-list="false" accept="xlsx"
          :on-success="handleExcelImportSuccess" style="display: inline-block">
          <el-button type="primary" class="ml-5">导入 <i class="el-icon-bottom"></i></el-button>
        </el-upload>
      </el-form-item>
      <el-form-item v-if="user.data.role === 'role_admin' || user.data.role === 'role_archives'">
        <el-button type="primary" @click="exp" class="ml-5">导出 <i class="el-icon-top"></i></el-button>
      </el-form-item>
    </el-form>
    <!-- 表格区域 -->
    <el-table :data="tableData" border stripe :header-cell-class-name="'headerBg'"
      @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <!-- <el-table-column prop="id" label="ID" width="80" sortable></el-table-column> -->
      <el-table-column prop="lendingInstitution" label="放款机构" width="140" fixed></el-table-column>
      <el-table-column prop="clientName" label="客户名称" width="100" fixed></el-table-column>
      <el-table-column prop="userCode" label="客户代码" width="150"></el-table-column>
      <el-table-column prop="loanContractId" label="借款合同编号" width="150"></el-table-column>
      <el-table-column prop="loanVoucherId" label="借款凭证编号" width="150"></el-table-column>
      <el-table-column prop="businessVariety" label="业务品种" width="150"></el-table-column>
      <el-table-column prop="loanAmount" label="借款金额" sortable width="150"></el-table-column>
      <el-table-column prop="loanDate" label="借款日期" sortable width="150">
        <template #default="{ row }">
          {{ formatTime(row.loanDate) }}
        </template>
      </el-table-column>
      <el-table-column prop="lastDate" label="到期日期" sortable width="150">
        <template #default="{ row }">
          {{ formatTime(row.lastDate) }}
        </template>
      </el-table-column>
      <el-table-column prop="file" label="档案材料" width="150">
        <template #default="{ row, $index }">
          <el-upload v-model:file-list="row.fileList" class="upload-demo" action="http://localhost:9090/file/upload"
            :on-preview="handlePreview" :on-error="errorMessage" multiple :on-remove="handleRemove"
            :before-remove="beforeRemove" :limit="3"
            :on-success="handleSuccess" show-file-list>
            <!-- <el-button size="small" type="primary">上传文件</el-button> -->
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
      <el-form :model="form" :rules="rules" ref="formRef" label-width="120px" size="small"
        style="width: 80%; margin: 0 auto">
        <el-form-item prop="lendingInstitution" label="放款机构">
          <el-input v-model="form.lendingInstitution" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="clientName" label="客户名称">
          <el-input v-model="form.clientName" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="userCode" label="客户代码">
          <el-input v-model="form.userCode" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="loanContractId" label="借款合同编号">
          <el-input v-model="form.loanContractId" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="loanVoucherId" label="借款凭证编号">
          <el-input v-model="form.loanVoucherId" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="businessVariety" label="业务品种">
          <el-input v-model="form.businessVariety" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="loanAmount" label="借款金额">
          <el-input v-model="form.loanAmount" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="loanDate" label="借款日期">
          <el-date-picker v-model="form.loanDate" type="date" placeholder="选择日期"></el-date-picker>
        </el-form-item>
        <el-form-item prop="lastDate" label="到期日期">
          <el-date-picker v-model="form.lastDate" type="date" placeholder="选择日期"></el-date-picker>
        </el-form-item>
        <el-form-item prop="file" label="文件">
          <el-upload v-model:file-list="form.fileList" class="upload-demo" action="http://localhost:9090/file/upload"
            :on-preview="handlePreview" :on-error="errorMessage" multiple :on-remove="handleRemove"
            :before-remove="beforeRemove" :limit="3" :on-success="handleSuccess" show-file-list>
            <el-button size="small" type="primary">上传文件</el-button>
            <template #tip>
              <div class="el-upload__tip">
              </div>
            </template>
          </el-upload>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="cancel">取 消</el-button>
          <el-button type="primary" @click="save">确 定</el-button>
        </div>
      </template>
    </el-dialog>
  </el-card>
</template>

<style scoped>
.headerBg {
  background: #eee !important;
}

.card {
  border-radius: 10px;
  min-height: 550px;
}
</style>

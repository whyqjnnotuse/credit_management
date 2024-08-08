<script setup>
import { ref, reactive, onMounted, watch, nextTick } from 'vue'
import { Edit, Delete } from '@element-plus/icons-vue'
import { formatTime, formatTime2 } from '@/utils/format.js'
import { GetListService, DelbatchListService, DelService, EditOrAddService, ExportService } from '@/api/management'

const tableData = ref([])
const loading = ref(false)
const form = ref({})
const formRef = ref(null);
const dialogFormVisible = ref(false)
const multipleSelection = ref([])
const user = reactive(localStorage.getItem("credit_user") ? JSON.parse(localStorage.getItem("credit_user")) : {})


const title = ref('')
// 总条数
const total = ref(0)
const params = ref({
  pageNum: 1,
  pageSize: 5,
  userCode: null,
  username: '',
  contractId: null,
  loanId: null,
  creditRecipients: ''
})
// 表单验证规则
const rules = {
  creditRecipients: [
    { required: true, message: '请输入放款机构', trigger: 'blur' }
  ],
  username: [
    { required: true, message: '请输入客户名称', trigger: 'blur' },
    { min: 2, max: 6, message: '长度在 2 到 6 个字符', trigger: 'blur' }
  ],
  userCode: [
    { required: true, message: '请输入客户代码', trigger: 'blur' },
    // { type: 'number',min: 3, max: 20, message: '客户代码必须为数字', trigger: 'blur' }
  ],
  loanId: [
    { required: true, message: '请输入借款凭证编号', trigger: 'blur' },
    // { type: 'number',min: 3, max: 20, message: '借款合同编号必须为数字', trigger: 'blur' }
  ],
  archiveLocation: [
    { required: true, message: '请输入档案位置', trigger: 'blur' },
  ],
  operationType: [
    { required: true, message: '请输入业务品种', trigger: 'blur' }
  ],
  contractId: [
    { required: true, message: '请输入合同号', trigger: 'blur' },
    // { type: 'number', message: '合同号必须为数字' }
  ],
  handoverTime: [
    { required: true, message: '请选择档案移交时间', trigger: 'blur' }
  ]
}
// 获取列表
const getManagementList = async () => {
  try {
    loading.value = true
    //   const newParams = {
    //   ...params,
    //   handoverTime: formatTime2(params.handoverTime)  
    // };
    // console.log(newParams.value);
    // console.log('params.value')
    console.log(params.value)
    const res = await GetListService(params.value)
    // console.log('res.data.data')
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
  params.value.userCode = ''
  params.value.username = ''
  params.value.contractId = ''
  params.value.loanId = ''
  params.value.creditRecipients = ''
  getManagementList()
}

// 搜索
const onSearch = async () => {
  console.log('搜索');
  params.value.pageNum = 1
  // params.value.creditRecipients = parseInt(creditRecipients.value, 20) || ''
  getManagementList()
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
    handoverTime: formatTime2(row.handoverTime)  // 假设 dateField 是你需要格式化的日期字段
  };
  form.value = { ...formattedRow };
  console.log(form.value)
  console.log(1111);
}
const save = async () => {
  console.log('保存')
  formRef.value.validate(async (valid) => {
    if (valid) {
      // Submit form
      await EditOrAddService(form.value)
      ElMessage.success('更新成功')
      getManagementList()
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
  let ids = multipleSelection.value?.map(v => v.id)  // [{}, {}, {}] => [1,2,3]
  await DelbatchListService(ids)
  ElMessage({ type: 'success', message: '批量删除成功' })
  getManagementList()
}
const deleteManage = async (row) => {
  await ElMessageBox.confirm('你确认删除该信息吗？', '温馨提示', {
    type: 'warning',
    confirmButtonText: '确认',
    cancelButtonText: '取消'
  })
  await DelService(row.id)
  ElMessage({ type: 'success', message: '删除成功' })
  getManagementList()
  console.log('删除')
}
// 导出
const exp = () => {
  window.open("http://localhost:9090/management/export")
}
// 选择项
const handleSelectionChange = (val) => {
  console.log(val)
  multipleSelection.value = val
}
const cancel = () => {
  dialogFormVisible.value = false;
  formRef.value.resetFields();
}
const closeDialog = () => {
  dialogFormVisible.value = false;
  formRef.value.resetFields();
}
// 处理分页逻辑
const handleSizeChange = (pageSize) => {
  // console.log('每页条数变化了' + size)
  // 只要每页条数变化了，访问的本页面就无意义了，要回到第一页
  params.value.pageNum = 1
  params.value.pageSize = pageSize
  // 基于当前的最新页和码数更新
  getManagementList()
}
const handleCurrentChange = (pageNum) => {
  // console.log('页码变化了' + page)
  // 基于最新的当前页渲染数据
  params.value.pageNum = pageNum
  getManagementList()
}

onMounted(() => {
  getManagementList()
})

// watch(dialogFormVisible, (newVal) => {
//   if (newVal) {
//     nextTick(() => {
//       if (formRef.value) {
//         formRef.value.resetFields();
//       }
//     });
//   }
// });
// watch(dialogFormVisible, () => {
//   formRef.value.resetFields()
// })   
</script>
<template>
  <el-card shadow="always" class="card">
    <!-- 表单区域 -->
    <el-form inline>
      <el-form-item label="客户代码">
        <el-input v-model.number="params.userCode" placeholder="请输入客户代码"></el-input>
      </el-form-item>
      <el-form-item label="客户名称">
        <el-input v-model="params.username" placeholder="请输入客户名称"></el-input>
      </el-form-item>
      <el-form-item label="借款合同">
        <el-input v-model.number="params.contractId" placeholder="请输入借款合同编号"></el-input>
      </el-form-item>
      <el-form-item label="借款凭证">
        <el-input v-model.number="params.loanId" placeholder="请输入借款凭证编号"></el-input>
      </el-form-item>
      <el-form-item label="档案位置">
        <el-input v-model.number="params.archiveLocation" placeholder="请输入档案位置"></el-input>
      </el-form-item>
      <!-- <el-form-item label="信贷对象">
        <el-select v-model="params.creditRecipients" style="width:105px">
          <el-option label="个人" value="个人"></el-option>
          <el-option label="法人" value="法人"></el-option>
        </el-select>
      </el-form-item> -->
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
        <!-- <el-upload action="http://localhost:9090/management/import" :show-file-list="false" accept="xlsx"
          :on-success="handleExcelImportSuccess" style="display: inline-block">
          <el-button type="primary" class="ml-5">导入 <i class="el-icon-bottom"></i></el-button>
        </el-upload> -->
      </el-form-item>
      <el-form-item v-if="user.data.role === 'role_admin' || user.data.role === 'role_archives'">
        <el-button type="primary" @click="exp" class="ml-5">导出 <i class="el-icon-top"></i></el-button>
      </el-form-item>
    </el-form>
    <!-- <div style="margin: 10px 0">
      <el-button type="primary" @click="handleAdd">新增 <i class="el-icon-circle-plus-outline"></i></el-button>
      <el-popconfirm class="ml-5" confirm-button-text='确定' cancel-button-text='我再想想' icon="el-icon-info"
        icon-color="red" title="您确定批量删除这些数据吗？" @confirm="delBatch">
      </el-popconfirm> -->

    <!-- </div> -->
    <!-- 表格区域 -->
    <el-table :data="tableData" border stripe :header-cell-class-name="'headerBg'"
      @selection-change="handleSelectionChange" v-loading="loading">
      <el-table-column type="selection" width="55"></el-table-column>
      <!-- <el-table-column prop="id" label="ID" width="80" sortable></el-table-column> -->
      <el-table-column prop="userCode" label="客户代码"></el-table-column>
      <el-table-column prop="username" label="客户名称" width="100"></el-table-column>
      <el-table-column prop="creditRecipients" label="信贷对象" width="100"></el-table-column>
      <el-table-column prop="operationType" label="业务品种"></el-table-column>
      <el-table-column prop="loanId" label="借款凭证编号"></el-table-column>
      <el-table-column prop="archiveLocation" label="档案位置" width="100"></el-table-column>
      <el-table-column prop="contractId" label="合同号" :label-class-name="'highlight'"></el-table-column>
      <el-table-column prop="handoverTime" label="档案移交时间" sortable>
        <template #default="{ row }">
          {{ formatTime(row.handoverTime) }}
        </template>
      </el-table-column>
      <el-table-column label="操作">
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
    <el-dialog :title="title" v-model="dialogFormVisible" width="40%" :before-close="closeDialog">
      <el-form :model="form" :rules="rules" ref="formRef" label-width="120px" size="small"
        style="width: 80%; margin: 0 auto">
        <el-form-item prop="userCode" label="客户代码">
          <el-input v-model="form.userCode" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="username" label="客户名称">
          <el-input v-model="form.username" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="creditRecipients" label="信贷对象">
          <el-input v-model="form.creditRecipients" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="operationType" label="业务品种">
          <el-input v-model="form.operationType" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="loanId" label="借款凭证编号">
          <el-input v-model="form.loanId" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="archiveLocation" label="档案位置">
          <el-input v-model="form.archiveLocation" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="contractId" label="合同号">
          <el-input v-model="form.contractId" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item prop="handoverTime" label="档案移交时间">
          <el-date-picker v-model="form.handoverTime" type="date" placeholder="选择日期时间"></el-date-picker>
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

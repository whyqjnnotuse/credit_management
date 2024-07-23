<script setup>
import { useUserStore } from '@/stores'
import { useRouter } from 'vue-router'
import { ref, reactive } from 'vue'
import { Edit, Delete } from '@element-plus/icons-vue'
import { formatTime } from '@/utils/format.js'
import { GetListService, AddListService, DelbatchListService, DelService, GetDetailServer, EditService } from '@/api/management'

const tableData = ref([])
const loading = ref(false)
const form = ref({})
const dialogFormVisible = ref(false)
const multipleSelection = ref([])
const user = reactive(localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : {})
const router = useRouter()
const store = useUserStore()
const articleList = ref([])
// 总条数
const total = ref(0)
const params = ref({
  pageNum: 1,
  pageSize: 10,
  username: '',
  creditRecipients: ''
})
// 重置
const onReset = () => {
  params.value.pageNum = 1
  params.value.username = ''
  params.value.creditRecipients = ''
  getManagementList()
}

// 搜索
const onSearch = () => {
  params.value.pageNum = 1
  getManagementList()
}
// 获取列表
const getManagementList = async () => {
  loading.value = true
  const res = await GetListService(params.value)
  tableData.value = res.data.data.records
  console.log(res.data.data)
  total.value = res.data.data.total
  loading.value = false
}
getManagementList()
const handleAdd = () => {
  console.log('add')
}
const editManage = () => {
  console.log('edit')
}
const deleteManage = () => {
  console.log('提交')
}
const delBatch = () => {
  console.log('批量删除')
}
const del = (id) => {
  console.log('删除')
  console.log(id)
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
</script>
<template>
  <!-- <div style="margin: 10px 0">
      <el-input style="width: 200px" placeholder="请输入名称" suffix-icon="el-icon-search" v-model="params.name"></el-input>
      <el-button class="ml-5" type="primary" @click="load">搜索</el-button>
      <el-button type="warning" @click="reset">重置</el-button>
    </div> -->
  <!-- 表单区域 -->
  <el-form inline>
    <el-form-item label="客户名称">
      <el-input v-model="params.username" placeholder="请输入名称"></el-input>
    </el-form-item>
    <el-form-item label="信贷对象">
      <el-select v-model="params.creditRecipients">
        <el-option label="个人" value="个人"></el-option>
        <el-option label="企业" value="企业"></el-option>
      </el-select>
    </el-form-item>
    <el-form-item>
      <el-button @click="onSearch" type="primary">搜索</el-button>
      <el-button @click="onReset">重置</el-button>
    </el-form-item>
  </el-form>
  <div style="margin: 10px 0">
    <el-button type="primary" @click="handleAdd">新增 <i class="el-icon-circle-plus-outline"></i></el-button>
    <el-popconfirm class="ml-5" confirm-button-text='确定' cancel-button-text='我再想想' icon="el-icon-info" icon-color="red"
      title="您确定批量删除这些数据吗？" @confirm="delBatch">
      <el-button type="danger" slot="reference">批量删除 <i class="el-icon-remove-outline"></i></el-button>
    </el-popconfirm>
    <!-- <el-upload action="http://localhost:9090/management/import" :show-file-list="false" accept="xlsx" :on-success="handleExcelImportSuccess" style="display: inline-block">
        <el-button type="primary" class="ml-5">导入 <i class="el-icon-bottom"></i></el-button>
      </el-upload>
      <el-button type="primary" @click="exp" class="ml-5">导出 <i class="el-icon-top"></i></el-button> -->
  </div>
  <el-table :data="tableData" border stripe :header-cell-class-name="'headerBg'"
    @selection-change="handleSelectionChange" v-loading="loading">
    <el-table-column type="selection" width="55"></el-table-column>
    <el-table-column prop="id" label="ID" width="80" sortable></el-table-column>
    <el-table-column prop="userCode" label="客户代码"></el-table-column>
    <el-table-column prop="username" label="客户名称"></el-table-column>
    <el-table-column prop="creditRecipients" label="信贷对象"></el-table-column>
    <el-table-column prop="operationType" label="业务品种"></el-table-column>
    <el-table-column prop="loanId" label="借款凭证编号"></el-table-column>
    <el-table-column prop="archiveLocation" label="档案位置"></el-table-column>
    <el-table-column prop="contractId" label="合同号"></el-table-column>
    <el-table-column prop="handoverTime" label="档案移交时间">
      <template #default="{ row }">
        {{ formatTime(row.pub_date) }}
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
  <el-pagination v-model:current-page="params.pageNum" v-model:page-size="params.pageSize" :page-sizes="[1, 2, 5, 10]"
    background layout="total, sizes, prev, pager, next, jumper" :total="total" @size-change="handleSizeChange"
    @current-change="handleCurrentChange" style="margin-top: 25px; justify-content: flex-end" />
  <el-dialog title="信息" :visible.sync="dialogFormVisible" width="40%" :close-on-click-modal="false">
    <el-form label-width="120px" size="small" style="width: 80%; margin: 0 auto">
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
        <el-date-picker v-model="form.handoverTime" type="datetime" value-format="yyyy-MM-dd HH:mm:ss"
          placeholder="选择日期时间"></el-date-picker>
      </el-form-item>

    </el-form>
    <div slot="footer" class="dialog-footer">
      <el-button @click="dialogFormVisible = false">取 消</el-button>
      <el-button type="primary" @click="save">确 定</el-button>
    </div>
  </el-dialog>
</template>

<style>
.headerBg {
  background: #eee !important;
}
</style>

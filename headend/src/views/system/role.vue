<script setup>
import { useRouter } from 'vue-router'
import { ref, reactive, onMounted, watch, nextTick } from 'vue'
import { Edit, Delete } from '@element-plus/icons-vue'
import { getRoleListService, RoleEditOrAddService, RoleDelService, RoleDelbatchService } from '@/api/system'

const router = useRouter()
const tableData = ref([])
const loading = ref(false)
const form = ref({})
const formRef = ref(null);
const dialogFormVisible = ref(false)
const multipleSelection = ref([])
const title = ref('')

// 总条数
const total = ref(0)
const params = ref({
  pageNum: 1,
  pageSize: 5,
  name: ''
})
// 获取列表
const getRoleList = async () => {
  try {
    loading.value = true
    const res = await getRoleListService(params.value)
    if (res.data && res.data.data) {
      tableData.value = res.data.data.records
      total.value = res.data.data.total
    } else {
      console.error('数据格式不正确', res2.data);
    }
    loading.value = false
  } catch (error) {
    console.error('获取数据失败', error);
  } finally {
    loading.value = false
  }
}
// 增
const addRole = () => {
  title.value = '新增角色'
  form.value = {}
  dialogFormVisible.value = true
  console.log('add')
}
// 改
const editRole = async (row) => {
  title.value = '修改角色'
  dialogFormVisible.value = true
  form.value = { ...row };
  console.log(form.value)

}

const save = async () => {
  console.log('保存')
  // formRef.value.validate(async (valid) => {
  //   if (valid) {
      // Submit form
      await RoleEditOrAddService(form.value)
      ElMessage.success('更新成功')
      getRoleList()
      dialogFormVisible.value = false;
      // formRef.value.resetFields();
    // } else {
    //   console.log('error submit!!');
    //   return false;
    // }
  // });
}
// 删
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
  await RoleDelbatchService(ids)
  ElMessage({ type: 'success', message: '批量删除成功' })
  getRoleList()
}
const deleteUser = async (row) => {
  await ElMessageBox.confirm('你确认删除该信息吗？', '温馨提示', {
    type: 'warning',
    confirmButtonText: '确认',
    cancelButtonText: '取消'
  })
  await RoleDelService(row.id)
  ElMessage({ type: 'success', message: '删除成功' })
  getRoleList()
  console.log('删除')
}

// 查
// 重置
const onReset = () => {
  params.value.pageNum = 1
  params.value.name = ''
  getRoleList()
}

// 搜索
const onSearch = async () => {
  console.log('搜索');
  params.value.pageNum = 1
  getRoleList()
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
  getRoleList()
}
const handleCurrentChange = (pageNum) => {
  // console.log('页码变化了' + page)
  // 基于最新的当前页渲染数据
  params.value.pageNum = pageNum
  getRoleList()
}
onMounted(() => {
  getRoleList()
})
</script>

<template>
  <el-card shadow="always" class="card">
    <el-form inline>
      <el-form-item label="名称">
        <el-input v-model="params.name" placeholder="请输入名称"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button @click="onSearch" type="primary">搜索</el-button>
        <el-button @click="onReset">重置</el-button>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="addRole">添加角色</el-button>
      </el-form-item>
      <el-form-item>
        <el-button type="danger" slot="reference" @click="delBatch">批量删除 <i
            class="el-icon-remove-outline"></i></el-button>
      </el-form-item>
    </el-form>
    <!-- 表格区域 -->
    <el-table :data="tableData" border stripe :header-cell-class-name="'headerBg'" v-loading="loading"
      @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55"></el-table-column>
      <el-table-column prop="id" label="ID" width="80"></el-table-column>
      <el-table-column prop="name" label="名称"></el-table-column>
      <el-table-column prop="flag" label="唯一标识"></el-table-column>
      <el-table-column prop="description" label="描述"></el-table-column>
      <el-table-column label="操作" width="110">
        <template #default="{ row, $index }">
          <el-button type="primary" :icon="Edit" circle plain @click="editRole(row, $index)"></el-button>
          <el-button type="danger" :icon="Delete" circle plain @click="deleteUser(row, $index)"></el-button>
        </template>
      </el-table-column>
    </el-table>
    <!-- 分页区域 -->
    <el-pagination v-model:current-page="params.pageNum" v-model:page-size="params.pageSize"
      :page-sizes="[1, 3, 5]" background layout="total, sizes, prev, pager, next, jumper" :total="total"
      @size-change="handleSizeChange" @current-change="handleCurrentChange"
      style="margin-top: 25px; justify-content: flex-end" />
    <!-- 对话框 -->
    <el-dialog :title="title" v-model="dialogFormVisible" width="30%">
      <el-form label-width="80px" size="small">
        <el-form-item label="名称">
          <el-input v-model="form.name" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="唯一标识">
          <el-input v-model="form.flag" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="描述">
          <el-input v-model="form.description" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="save">确 定</el-button>
      </div>
    </el-dialog>

  </el-card>
</template>

<style scoped>
.card {
  border-radius: 10px;
  min-height: 550px;
}
</style>
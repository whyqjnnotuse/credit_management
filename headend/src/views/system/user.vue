<script setup>
import { useRouter } from 'vue-router'
import { ref, reactive, onMounted, watch, nextTick } from 'vue'
import { Edit, Delete } from '@element-plus/icons-vue'
import { getUserListService, DelbatchListService, DelService, EditOrAddService, getRoleService } from '@/api/system'

const router = useRouter()
const tableData = ref([])
const loading = ref(false)
const form = ref({})
const formRef = ref(null);
const dialogFormVisible = ref(false)
const multipleSelection = ref([])

const roles = ref([])

// 总条数
const total = ref(0)
const params = ref({
  pageNum: 1,
  pageSize: 5,
  username: '',
  nickname:'',
  role:''
})

// 获取列表
const getUserList = async () => {
  try {
    loading.value = true
    // console.log(params.value)
    const res = await getUserListService(params.value)
    // console.log(res.data.data)
    const res2 = await getRoleService()
    // console.log(res2.data)
    if (res.data && res.data.data && res2.data) {
      tableData.value = res.data.data.records
      total.value = res.data.data.total
      roles.value = res2.data.data
      console.log(roles.value);
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

// // 增
// const addUser = () => {
//   form.value = {}
//   dialogFormVisible.value = true
//   console.log('add')
// }

// 改
const editUser = async (row) => {
  dialogFormVisible.value = true
  form.value = { ...row };
  console.log(form.value)

}

const save = async () => {
  console.log('保存')
  // formRef.value.validate(async (valid) => {
  //   if (valid) {
      // Submit form
      await EditOrAddService(form.value)
      ElMessage.success('更新成功')
      getUserList()
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
  await DelbatchListService(ids)
  ElMessage({ type: 'success', message: '批量删除成功' })
  getUserList()
}
const deleteUser = async (row) => {
  await ElMessageBox.confirm('你确认删除该信息吗？', '温馨提示', {
    type: 'warning',
    confirmButtonText: '确认',
    cancelButtonText: '取消'
  })
  await DelService(row.id)
  ElMessage({ type: 'success', message: '删除成功' })
  getUserList()
  console.log('删除')
}

// 查
// 重置
const onReset = () => {
  params.value.pageNum = 1
  params.value.username = ''
  params.value.nickname = ''
  params.value.role = ''
  getUserList()
}

// 搜索
const onSearch = async () => {
  console.log('搜索');
  params.value.pageNum = 1
  getUserList()
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
  getUserList()
}
const handleCurrentChange = (pageNum) => {
  // console.log('页码变化了' + page)
  // 基于最新的当前页渲染数据
  params.value.pageNum = pageNum
  getUserList()
}
onMounted(() => {
  getUserList()
})
</script>

<template>
  <el-card shadow="always" class="card">
    <el-form inline>
      <el-form-item label="用户名">
        <el-input v-model="params.username" placeholder="请输入用户名"></el-input>
      </el-form-item>
      <el-form-item label="昵称">
        <el-input v-model="params.nickname" placeholder="请输入昵称"></el-input>
      </el-form-item>
      <el-form-item label="角色">
        <el-input v-model="params.role" placeholder="请输入角色"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button @click="onSearch" type="primary">搜索</el-button>
        <el-button @click="onReset">重置</el-button>
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
      <!-- <el-table-column prop="id" label="ID" width="80"></el-table-column> -->
      <el-table-column prop="username" label="用户名" width="140"></el-table-column>
      <el-table-column label="角色" prop="role">
        <template v-slot="scope">
        <span v-if="scope.row.role && Array.isArray(roles.value) && roles.value.length > 0">
      {{ roles.value.find(v => v.flag === scope.row.role) ? roles.value.find(v => v.flag === scope.row.role).name : '' }}
    </span>
  </template>
      </el-table-column>
      <el-table-column prop="nickname" label="昵称" width="120"></el-table-column>
      <el-table-column prop="email" label="邮箱"></el-table-column>
      <el-table-column prop="phone" label="电话"></el-table-column>
      <el-table-column prop="address" label="地址"></el-table-column>
      <el-table-column label="操作" width="110">
        <template #default="{ row, $index }">
          <el-button type="primary" :icon="Edit" circle plain @click="editUser(row, $index)"></el-button>
          <el-button type="danger" :icon="Delete" circle plain @click="deleteUser(row, $index)"></el-button>
        </template>
      </el-table-column>
    </el-table>
    <!-- 分页区域 -->
    <el-pagination v-model:current-page="params.pageNum" v-model:page-size="params.pageSize"
      :page-sizes="[1, 5, 10, 20]" background layout="total, sizes, prev, pager, next, jumper" :total="total"
      @size-change="handleSizeChange" @current-change="handleCurrentChange"
      style="margin-top: 25px; justify-content: flex-end" />
    <!-- 对话框 -->
    <el-dialog title="用户信息" v-model="dialogFormVisible" width="30%">
      <el-form label-width="80px" size="small">
        <el-form-item label="用户名">
          <el-input v-model="form.username" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="角色">
          <el-select clearable v-model="form.role" placeholder="请选择角色" style="width: 100%">
            <el-option v-for="item in roles" :key="item.name" :label="item.name" :value="item.flag"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="昵称">
          <el-input v-model="form.nickname" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="邮箱">
          <el-input v-model="form.email" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="电话">
          <el-input v-model="form.phone" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="地址">
          <el-input v-model="form.address" autocomplete="off"></el-input>
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
<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useUserStore } from '@/stores'
import { userUpdatePassService } from '@/api/user'
const user = ref(localStorage.getItem("credit_user") ? JSON.parse(localStorage.getItem("credit_user")) : {})
const formRef = ref()

const pwdForm = ref({
  username:'',
  password: '',
  newPassword: '',
  confirmPassword: ''
})
// 校验函数
const checkOldSame = (rule, value, cb) => {
  if (value === pwdForm.value.password) {
    cb(new Error('原密码和新密码不能一样!'))
  } else {
    cb()
  }
}
// 校验函数
const checkNewSame = (rule, value, cb) => {
  if (value !== pwdForm.value.newPassword) {
    cb(new Error('新密码和确认再次输入的新密码不一样!'))
  } else {
    cb()
  }
}
const rules = {
  // 原密码
  password: [
    { required: true, message: '请输入密码', trigger: 'blur' },
    {
      pattern: /^\S{3,15}$/,
      message: '密码长度必须是3-15位的非空字符串',
      trigger: 'blur'
    }
  ],
  // 新密码
  newPassword: [
    { required: true, message: '请输入新密码', trigger: 'blur' },
    {
      pattern: /^\S{3,15}$/,
      message: '密码长度必须是3-15位的非空字符串',
      trigger: 'blur'
    },
    { validator: checkOldSame, trigger: 'blur' }
  ],
  // 确认新密码
  confirmPassword: [
    { required: true, message: '请再次确认新密码', trigger: 'blur' },
    {
      pattern: /^\S{3,15}$/,
      message: '密码长度必须是3-15位的非空字符串',
      trigger: 'blur'
    },
    { validator: checkNewSame, trigger: 'blur' }
  ]
}
const userStore = useUserStore()
const router = useRouter()
const onSubmit = async () => {
  const valid = await formRef.value.validate()
  if (valid) {
    pwdForm.value.username = user.value.data.username
    // pwdForm.value.password = user.value.password
    await userUpdatePassService(pwdForm.value)
    ElMessage({ type: 'success', message: '更换密码成功' })
    userStore.setToken('')
    userStore.setUser({})
    router.push('/login')
  }
}
const onReset = () => {
  formRef.value.resetFields()
}
</script>
<template>
  <el-card>
    <el-row style="margin:50px 0 0 25px;">
      <el-col :span="20">
        <el-form
          :model="pwdForm"
          :rules="rules"
          ref="formRef"
          label-width="100px"
          size="large"
        >
          <el-form-item label="原密码" prop="password">
            <el-input
              v-model="pwdForm.password"
              type="password"
              show-password
            ></el-input>
          </el-form-item>
          <el-form-item label="新密码" prop="newPassword">
            <el-input
              v-model="pwdForm.newPassword"
              type="password"
              show-password
            ></el-input>
          </el-form-item>
          <el-form-item label="确认新密码" prop="confirmPassword">
            <el-input
              v-model="pwdForm.confirmPassword"
              type="password"
              show-password
            ></el-input>
          </el-form-item>
          <el-form-item style="margin-top: 50px;">
            <el-button @click="onSubmit" type="primary">修改密码</el-button>
            <el-button @click="onReset">重置</el-button>
            <!-- <el-row>
              <el-col :span="12"><el-button @click="onSubmit" type="primary">修改密码</el-button></el-col>
              <el-col :span="12"><el-button @click="onReset">重置</el-button></el-col>
            </el-row> -->
          </el-form-item>
        </el-form>
      </el-col>
    </el-row>
  </el-card>
</template>
<style scoped>
.el-card {
  width: 550px;
  border-radius: 10px;
  min-height: 450px;
}
.el-form-item{
  margin-bottom: 40px;
}

.el-button+.el-button {
    margin-left: 137px;
}
</style>
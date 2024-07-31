<script setup>
import { useUserStore } from '@/stores'
import { ref, onMounted } from 'vue'
import { userUpdateInfoService, userInfoService } from '@/api/user'
const formRef = ref()
const form = ref({})
const uploadRef = ref()
const user = ref(localStorage.getItem("credit_user") ? JSON.parse(localStorage.getItem("credit_user")) : {})

const getUser = async () => {
  // console.log('user.value');
  const username = user.value.data.username
  // console.log(username);
  const res = await userInfoService(username)
  // console.log(res);
  form.value = res.data.data
  // console.log(form.value);
}

const handleAvatarSuccess = (file) => {
  const reader = new FileReader()
  reader.readAsDataURL(file.raw)
  reader.onload = () => {
    form.value.avatarUrl = reader.result
    console.log(reader);
  }
}
// const handleAvatarSuccess = (res) => {
//   console.log(res.name);
//   form.value.avatarUrl = res.name
//   console.log(form.value);
// }
const save = async () => {
  // localStorage.setItem("user", JSON.stringify(form.value))
  await userUpdateInfoService(form.value)
  ElMessage({ type: 'success', message: '更换信息成功' })
  getUser()
}
onMounted(() => {
  getUser()
})

</script>

<template>
  <el-card>
    <el-form label-width="80px" :rules="rules">
      <!-- shape="circle" -->
      <el-upload ref="uploadRef" class="avatar-uploader" action="http://localhost:9090/file/upload" :auto-upload="false"
        :show-file-list="false" :on-change="handleAvatarSuccess">
        <img v-if="form.avatarUrl" :src="form.avatarUrl" class="avatar" />
        <img v-else src="https://cube.elemecdn.com/9/c2/f0ee8a3c7c9638a54940382568c9dpng.png" width="278" />
      </el-upload>
      <!-- <el-upload
          class="avatar-uploader"
          action="http://localhost:9090/file/upload"
          :show-file-list="false"
          :on-success="handleAvatarSuccess"
      >
        <img v-if="form.avatarUrl" :src="form.avatarUrl" class="avatar">
        <i v-else class="el-icon-plus avatar-uploader-icon"></i>
      </el-upload> -->

      <el-form-item label="用户名">
        <el-input v-model="form.username" disabled autocomplete="off"></el-input>
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
        <el-input type="textarea" v-model="form.address" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="save">确 定</el-button>
      </el-form-item>
    </el-form>
  </el-card>
</template>
<style lang="scss" scoped>
.el-card{
  border-radius: 10px;
  min-height: 550px;
  width: 580px;
}
.avatar-uploader {
  text-align: center;
  padding-bottom: 10px;
}

.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}

.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}

.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 138px;
  height: 138px;
  line-height: 138px;
  text-align: center;
}

.avatar {
  width: 138px;
  height: 138px;
  display: block;
}
</style>

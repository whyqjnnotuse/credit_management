<script setup>
import {
  User,
  Promotion,
  Management,
  UserFilled,
  Crop,
  Avatar,
  List,
  Key,
  Setting,
  Grid,
  EditPen,
  CaretBottom,
  SwitchButton
} from '@element-plus/icons-vue'
import avatar from '@/assets/default.png'
import { useUserStore } from '@/stores'
import { useRouter } from 'vue-router'
import { ref } from 'vue'
const user = ref(localStorage.getItem("credit_user") ? JSON.parse(localStorage.getItem("credit_user")) : {})
const avatarUrl = ref(user.value.data.avatarUrl)
const userStore = useUserStore()
const router = useRouter()
// onMounted(() => {
//   userStore.getUser()
// })
const handleCommand = async (key) => {
  if (key === 'logout') {
    // 弹框
    await ElMessageBox.confirm('确认退出吗?', '温馨提示', {
      confirmButtonText: '确认',
      cancelButtonText: '取消',
      type: 'warning'
    })
    // 退出登录,清除token
    userStore.removeToken()
    userStore.setUser({})
    ElMessage.success('退出成功')
    router.push('/login')
  } else {
    // 跳转页面
    router.push(`/user/${key}`)
  }
}

const menus = ref(localStorage.getItem("menus") ? JSON.parse(localStorage.getItem("menus")) : [])
const opens = ref(localStorage.getItem("menus") ? JSON.parse(localStorage.getItem("menus")).map(v => v.id + '') : [])
</script>
<template>
  <el-container class="layout-container">
    <el-aside width="200px">
      <div class="el-aside__logo"></div>
      <el-menu active-text-color="#ffd04b" background-color="#232323" :default-active="$route.path" text-color="#fff"
        router unique-opened>
        <!-- 系统入库 -->
        <el-menu-item index="/detail">
          <el-icon>
            <Management />
          </el-icon>
          <span>档案入库</span>
        </el-menu-item>
        <!-- 档案管理 -->
        <el-menu-item index="/management">
          <el-icon>
            <Promotion />
          </el-icon>
          <span>档案管理</span>
        </el-menu-item>
        <!-- 未交档案 -->
        <el-menu-item index="/unpaid">
          <el-icon>
            <List />
          </el-icon>
          <span>未交档案</span>
        </el-menu-item>
        <!-- 个人中心 -->
        <el-sub-menu index="/user">
          <template #title>
            <el-icon>
              <UserFilled />
            </el-icon>
            <span>个人中心</span>
          </template>
          <el-menu-item index="/user/profile">
            <el-icon>
              <User />
            </el-icon>
            <span>基本资料</span>
          </el-menu-item>
          <el-menu-item index="/user/password">
            <el-icon>
              <EditPen />
            </el-icon>
            <span>重置密码</span>
          </el-menu-item>
        </el-sub-menu>
        <el-sub-menu index="/system">
          <template #title>
            <el-icon><Grid /></el-icon>
            <span>系统管理</span>
          </template>
          <el-menu-item index="/system/user">
            <el-icon><Avatar /></el-icon>
            <span>用户管理</span>
          </el-menu-item>
          <el-menu-item index="/system/role">
            <el-icon><Key /></el-icon>
            <span>角色管理</span>
          </el-menu-item>
        </el-sub-menu>
      </el-menu>
    </el-aside>
    <el-container>
      <el-header>
        <div>
          <strong>{{
        userStore.user.nickname || userStore.user.username
      }}</strong>
        </div>
        <el-dropdown placement="bottom-end" @command="handleCommand">
          <span class="el-dropdown__box">
            <el-avatar :src="avatarUrl || avatar" />
            <el-icon>
              <CaretBottom />
            </el-icon>
          </span>
          <template #dropdown>
            <el-dropdown-menu>
              <el-dropdown-item command="profile" :icon="User">基本资料</el-dropdown-item>
              <el-dropdown-item command="password" :icon="EditPen">重置密码</el-dropdown-item>
              <el-dropdown-item command="logout" :icon="SwitchButton">退出登录</el-dropdown-item>
            </el-dropdown-menu>
          </template>
        </el-dropdown>
      </el-header>
      <el-main>
        <router-view></router-view>
      </el-main>
      <el-footer>信贷档案管理系统 ©2024 </el-footer>
    </el-container>
  </el-container>
</template>

<style lang="scss" scoped>
.layout-container {
  height: 100vh;

  .el-aside {
    background-color: #232323;

    &__logo {
      height: 100px;
      background: url('@/assets/logo.png') no-repeat center / 80px auto;
    }

    .el-menu {
      border-right: none;
    }
  }

  .el-header {
    background-color: #fff;
    display: flex;
    align-items: center;
    justify-content: space-between;

    .el-dropdown__box {
      display: flex;
      align-items: center;

      .el-icon {
        color: #999;
        margin-left: 10px;
      }

      &:active,
      &:focus {
        outline: none;
      }
    }
  }

  .el-footer {
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
    color: #666;
  }
}
</style>

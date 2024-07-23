import { defineStore } from 'pinia'
import { ref } from 'vue'
import { userLoginService } from '@/api/user'
export const useUserStore = defineStore(
  'credit',
  () => {
    const token = ref('')
    const setToken = (newToken) => {
      token.value = `${newToken}`
      localStorage.setItem('token', token.value); // 确保token存储到localStorage中
    }
    const removeToken = () => {
      token.value = ''
    }
    // 获取用户信息
    // const user = ref({})
    // const getUser = async () => {
    //   try {
    //     const res = await userLoginService();
    //     if (res.data && res.data.data) {
    //       // console.log(res.data);
    //       user.value = res.data.data
    //     } else {
    //       console.error('Invalid user info response');
    //       user.value = {}; // 或者使用默认值
    //     }
    //   } catch (error) {
    //     console.error("Error fetching user information:", error);
    //     user.value = {}; // 或者使用默认值
    //   }
    // };
    const user = ref({})
    const setUser = (obj) => {
      user.value = obj;
    }
    return {
      token,
      setToken,
      removeToken,
      user,
      // getUser,
      setUser
    }
  },
  {
    persist: true
  }
)

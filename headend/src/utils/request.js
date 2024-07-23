import axios from 'axios'
import { useUserStore } from '@/stores/modules/user'
import { ElMessage } from 'element-plus'
import router from '@/router'
const baseURL = 'http://localhost:9090'

const instance = axios.create({
  // TODO 1. 基础地址，超时时间
  baseURL,
  timeout: 10000
})

// 请求拦截器
instance.interceptors.request.use(
  // (config) => {
  //   // TODO 2. 携带token
  //   const useStore = useUserStore()
  //   if (useStore.token) {
  //     config.headers.Authorization = useStore.token
  //   }
  //   return config
  // },
  // (err) => Promise.reject(err)
  config => {
    // 在请求发送之前设置token
    const token = localStorage.getItem('token'); // 从localStorage获取token
    if (token) {
      config.headers['token'] = token; // 设置请求头
    }
    return config;
  },
  error => {
    // 处理请求错误
    return Promise.reject(error);
  }
)

// 响应拦截器
instance.interceptors.response.use(
  (res) => {
    // TODO 4. 摘取核心响应数据
    if (res.data.code === '200') {
      return res
    }

    // TODO 3. 处理业务失败
    // 处理业务失败, 给错误提示，抛出错误
    console.log(1);
    ElMessage.error(res.data.msg || '服务异常')

    return Promise.reject(res.data)
  },
  (err) => {
    // TODO 5. 处理401错误
    // 错误的特殊情况 => 401 权限不足 或 token 过期 => 拦截到登录
    if (err.response?.status === 401) {
      router.push('/login')
    }
    // 错误的默认情况 => 只要给提示
    console.log(2);
    ElMessage.error(err.response.data.message || '服务异常')
    return Promise.reject(err)
  }
)

export default instance

import request from '@/utils/request'

// 注册接口
export const userRegisterService = ({ username, password, repassword }) =>
  request.post('/user/register', { username, password, repassword })

// 登录接口 获取用户信息
export const userLoginService = ({ username, password }) =>
  request.post('/user/login', { username, password })

// 更新用户信息
export const userUpdateInfoService = ({ id, nickname, email }) =>
  request.put('/my/userinfo', { id, nickname, email })

// 更新头像信息
export const userUploadAvatarService = (avatar) =>
  request.patch('/my/update/avatar', { avatar })

// 更新密码信息
export const userUpdatePassService = ({ old_pwd, new_pwd, re_pwd }) =>
  request.patch('/my/updatepwd', { old_pwd, new_pwd, re_pwd })

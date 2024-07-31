import request from '@/utils/request'

// 用户管理：获取用户列表 
export const getUserListService = (params) =>
  request.get('/user/page', {
  params
})

// 用户管理：编辑或新增档案
export const EditOrAddService = (data) => 
  request.post('/user', data)

// 用户管理：批量删除列表 
export const DelbatchListService = (params) =>
  request.post('/user/del/batch',params)

// 用户管理：删除档案列表
export const DelService = (id) =>
  request.delete(`/user/${id}`)

// 角色管理：获取权限
export const getRoleService = () =>
  request.get('/role')

// 角色管理：获取角色列表 
export const getRoleListService = (params) => 
  request.get('/role/page', {
  params
})

// 角色管理：编辑或新增档案
export const RoleEditOrAddService = (data) => 
  request.post('/role', data)

// 角色管理：删除档案列表
export const RoleDelService = (id) =>
  request.delete(`/role/${id}`)

// 角色管理：批量删除列表
export const RoleDelbatchService = (params) =>
  request.post('/role/del/batch',params)
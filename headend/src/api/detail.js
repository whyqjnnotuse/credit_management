import request from '@/utils/request'
// 档案管理：获取档案列表 
export const GetListService = (params) =>
  request.get('/management/page', {
    params
  })

  // 档案入库：新增档案列表 
export const AddListService = (params) =>
  request.post('/management', {
    params
  })
import request from '@/utils/request'

// 档案入库：获取档案列表 
export const GetListService = (params) =>
  request.get('/management/page', {
    params
  })

  // 档案入库：新增档案列表 
export const AddListService = (params) =>
  request.post('/management', {
    params
  })
    // 档案入库：批量删除列表 
export const DelbatchListService = (params) =>
  request.delete('/del/batch', {
    params
  })
// 档案入库：删除档案列表
export const DelService = (id) =>
  request.delete(`/management/${id}`)


// 档案入库：获取档案详情
export const GetDetailServer = (id) =>
  request.get(`/management/${id}`)
// 档案入库：编辑
export const EditService = (data) => request.put('/management', data)

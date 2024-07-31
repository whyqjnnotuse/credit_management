import request from '@/utils/request'

// 档案管理：获取档案列表 
export const GetListService = (params) =>
  request.get('/management/page', {
    params
  })

  // 档案管理：获取档案
export const GetSearchService = (params) =>
  request.get('/management', {
    params
  })

// 档案管理：编辑或新增档案
export const EditOrAddService = (data) => 
  request.post('/management', data)

// 档案管理：批量删除列表 
export const DelbatchListService = (params) =>
  request.post('/management/del/batch',params)

// 档案管理：删除档案列表
export const DelService = (id) =>
  request.delete(`/management/${id}`)

// 档案管理：获取档案详情
export const GetDetailServer = (id) =>
  request.get(`/management/${id}`)

// 档案管理：导出
export const ExportService = (params) => 
request.get('/management/export', { params })
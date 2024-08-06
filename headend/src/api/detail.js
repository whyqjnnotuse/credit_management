import request from '@/utils/request'
// 档案入库：获取档案列表 
export const GetListService = (params) =>
  request.get('/detail/page', {
    params
  })

// 档案入库：编辑或新增档案
export const EditOrAddService = (data) => 
  request.post('/detail', data)

// 档案入库：批量删除列表 
export const DelbatchListService = (params) =>
  request.post('/detail/del/batch',params)

// 档案入库：删除档案列表
export const DelService = (id) =>
  request.delete(`/detail/${id}`)

// 档案入库：获取档案详情
export const GetDetailServer = (id) =>
  request.get(`/detail/${id}`)

// 档案入库：导出
export const ExportService = (params) => 
request.get('/detail/export', { params })

// 档案入库：导入
export const ImportService = (params) => 
  request.post('/detail/import', { params })
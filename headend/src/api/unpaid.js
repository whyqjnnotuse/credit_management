import request from '@/utils/request'
// 未交档案：获取档案列表 
export const GetListService = (params) =>
  request.get('/combinedTable/page', {
    params
  })

// 未交档案：编辑或新增档案
export const EditOrAddService = (data) => 
  request.post('/combinedTable', data)

// 未交档案：批量删除列表 
export const DelbatchListService = (params) =>
  request.post('/combinedTable/del/batch',params)

// 未交档案：删除档案列表
export const DelService = (userCode) =>
  request.delete(`/combinedTable/${userCode}`)

// 未交档案：合并表数据
export const MergeService = () =>
  request.post('/combinedTable/merge')
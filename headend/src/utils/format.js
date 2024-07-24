import { dayjs } from 'element-plus'

export const formatTime = (time) => dayjs(time).format('YYYY年MM月DD日')
export const formatTime2 = (time) => dayjs(time).format('YYYY-MM-DD')
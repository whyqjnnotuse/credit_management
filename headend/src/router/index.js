import { createRouter, createWebHistory } from 'vue-router'
const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    { path: '/login', component: () => import('@/views/login/LoginPage.vue') },
    {
      path: '/',
      component: () => import('@/views/layout/LayoutContainer.vue'),
      redirect: '/unpaid',
      children: [
        {
          path: '/management',
          component: () => import('@/views/Management.vue')
        },
        {
          path: '/unpaid',
          component: () => import('@/views/Unpaid.vue')
        },
        {
          path: '/detail',
          component: () => import('@/views/Detail.vue')
        },
        {
          path: '/system/user',
          component: () => import('@/views/system/user.vue')
        },
        {
          path: '/system/role',
          component: () => import('@/views/system/role.vue')
        },
        {
          path: '/user/profile',
          component: () => import('@/views/user/UserProfile.vue')
        },
        {
          path: '/user/password',
          component: () => import('@/views/user/UserPassword.vue')
        }
      ]
    }
  ]
})

export default router

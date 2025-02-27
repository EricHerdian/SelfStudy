import React from 'react'
import ReactDOM from 'react-dom/client'
import './index.css'
import { createBrowserRouter, RouterProvider } from 'react-router-dom'
import LoginPage from './pages/login'
import RegisterPage from './pages/register'
import ErrorPage from './pages/404'
import ProductPage from './pages/product'
import ProfilePage from './pages/profile'
import DetailProductPage from './pages/detailProduct'
import { Provider } from 'react-redux'
import store from './redux/store'

const router = createBrowserRouter([
	{
		path: '/',
		element: <div>Hello World</div>,
		errorElement: <ErrorPage />,
	},

	{
		path: '/login',
		element: <LoginPage />,
	},

	{
		path: '/register',
		element: <RegisterPage />,
	},

	{
		path: '/products',
		element: <ProductPage />,
	},

	{
		path: '/profile',
		element: <ProfilePage />,
	},

	{
		path: '/product/:id',
		element: <DetailProductPage />,
	},
])

ReactDOM.createRoot(document.getElementById('root')).render(
	<React.StrictMode>
		<Provider store={store}>
			<RouterProvider router={router} />
		</Provider>
	</React.StrictMode>,
)

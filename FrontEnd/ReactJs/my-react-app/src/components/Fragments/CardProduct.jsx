import { Link } from 'react-router-dom'
import Button from '../Elements/Button'
import { useDispatch } from 'react-redux'
import { addToCart } from '../../redux/slices/cartSlice'

export default function CardProduct({ children }) {
	return (
		<div className='w-full max-w-sm bg-gray-800 border border-gray-700 rounded-lg shadow m-3 p-5 flex flex-col justify-between'>
			{children}
		</div>
	)
}

function Header({ image, id }) {
	return (
		<Link to={`/product/${id}`}>
			<img
				src={image}
				alt='product'
				className='p-8 rounded-tl-lg h-60 w-full object-cover'
			/>
		</Link>
	)
}

function Body({ title, children }) {
	return (
		<div className='px-5 pb-5 h-full'>
			<a href=''>
				<h5 className='text-xl font-semibold tracking-tight text-white'>
					{title.substring(0, 20)} ...
				</h5>
				<p className='text-m text-white text-justify'>
					{children.substring(0, 100)} ...
				</p>
			</a>
		</div>
	)
}

function Footer({ price, handleAddToCart, id }) {
	const dispatch = useDispatch()
	return (
		<div className='flex items-center justify-between px-5 pb-5'>
			<span className='text-xl font-bold text-white'>
				{price.toLocaleString('id-ID', {
					style: 'currency',
					currency: 'IDR',
				})}
			</span>
			<Button
				classname='bg-blue-600 '
				onClick={() => dispatch(addToCart({ id: id, qty: 1 }))}
			>
				Add To Cart
			</Button>
		</div>
	)
}

CardProduct.Header = Header
CardProduct.Body = Body
CardProduct.Footer = Footer

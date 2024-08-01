import { forwardRef } from 'react'

const Input = forwardRef((props, ref) => {
	const { placeholder, type, name } = props
	return (
		<input
			type={type}
			className="text-sm border rounded 2-full py-2 px-3 text-slate-700 placeholder: opacity-50 w-full"
			placeholder={placeholder}
			name={name}
			ref={ref}
		/>
	)
})

export default Input

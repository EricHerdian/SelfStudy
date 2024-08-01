export default function Button({
	classname = 'bg-black',
	children,
	onClick = () => {},
	type = 'button',
}) {
	const buttonClass = `h-10 px-6 font-semibold rounded-md ${classname} text-white`

	return (
		<button
			className={buttonClass}
			type={type}
			onClick={onClick}
		>
			{children}
		</button>
	)
}

import Button from '../Elements/Button'
import InputForm from '../Elements/Input'

export default function FormRegister() {
	return (
		<form action="">
			<InputForm
				label="Full Name"
				type="text"
				placeholder="Insert your name here..."
				name="fullname"
			/>

			<InputForm
				label="Email"
				type="email"
				placeholder="example@gmail.com"
				name="email"
			/>

			<InputForm
				label="Password"
				type="password"
				placeholder="********"
				name="password"
			/>

			<InputForm
				label="Confirm Password"
				type="password"
				placeholder="********"
				name="confirmPassword"
			/>

			<Button classname="bg-blue-600 w-full">Register</Button>
		</form>
	)
}

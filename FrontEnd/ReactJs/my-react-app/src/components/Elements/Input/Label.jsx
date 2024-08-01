export default function Label({ htmlForm, children }) {
	return (
		<label
			htmlFor={htmlForm}
			className="block text-slate-700 text-sm font-bold mb-2"
		>
			{children}
		</label>
	)
}

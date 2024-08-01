function getRandomInt(count) {
  return Math.floor(Math.random() * count)
}

export default function ProductDetailsLayout({ children }) {
  const random = getRandomInt(2)

  if (random === 1) {
    throw new Error('Error loading product')
  }

  return (
    <>
      {children}
      <h2>Feature Products</h2>
    </>
  )
}

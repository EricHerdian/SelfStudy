import Link from 'next/link'
import Card from '/src/components/card'

export default function Notifications() {
  return (
    <Card>
      <div>Notifications</div>
      <Link href="/complex-dashboard/archived">Archived</Link>
    </Card>
  )
}

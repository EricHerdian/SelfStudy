import { comments } from '../data'

export async function GET(_request, { params: { id } }) {
  const comment = comments.find((comment) => comment.id === parseInt(id))
  return Response.json(comment)
}

export async function PATCH(request, { params: { id } }) {
  const body = await request.json()
  const { text } = body
  const index = comments.findIndex((comment) => comment.id === parseInt(id))
  comments[index].text = text
  return Response.json(comments[index])
}

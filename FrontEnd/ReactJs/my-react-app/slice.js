import * as toolkit from '@reduxjs/toolkit'

const { createAction, createSlice } = toolkit

const cartSlice = createSlice({
	name: 'cart',
	initialState: [],
	reducers: {
		addToCart: (state, action) => {
			state.push(action.payload)
		},
	},
})

const store = toolkit.configureStore({
	reducer: {
		cart: cartSlice.reducer,
	},
})

store.dispatch(cartSlice.actions.addToCart({ id: 1, qty: 5 }))

import * as toolkit from '@reduxjs/toolkit'

const { createAction, createReducer, configureStore } = toolkit

const addToCart = createAction('ADD_TO_CART')

const counterReducer = createReducer([], (builder) => {
	builder
		.addCase(addToCart, (state, action) => {
			state.push(action.payload)
		})
		.addDefaultCase((state, action) => state)
})

const store = configureStore({
	reducer: {
		cart: createReducer,
	},
})

store.dispatch(addToCart({ id: 1, qty: 5 }))

store.subscribe()

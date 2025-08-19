import { describe, it, expect } from 'vitest'
import { mount } from '@vue/test-utils'
import App from '../App.vue'

describe('App', () => {
    it('renders properly', () => {
        const wrapper = mount(App)

        expect(wrapper.exists()).toBe(true)
    })

    it('contains HelloWorld component', () => {
        const wrapper = mount(App)

        // Check if HelloWorld component is rendered
        expect(wrapper.findComponent({ name: 'HelloWorld' }).exists()).toBe(true)
    })

    it('passes correct props to HelloWorld', () => {
        const wrapper = mount(App)

        const helloWorldComponent = wrapper.findComponent({ name: 'HelloWorld' })
        expect(helloWorldComponent.props('msg')).toBe('Vite + Vue')
    })

    it('contains logo images', () => {
        const wrapper = mount(App)

        const images = wrapper.findAll('img')
        expect(images.length).toBeGreaterThan(0)

        // Check for Vite logo
        const viteLogo = images.find(img => img.attributes('alt') === 'Vite logo')
        expect(viteLogo).toBeTruthy()

        // Check for Vue logo
        const vueLogo = images.find(img => img.attributes('alt') === 'Vue logo')
        expect(vueLogo).toBeTruthy()
    })

    it('has correct CSS classes', () => {
        const wrapper = mount(App)

        expect(wrapper.find('.logo').exists()).toBe(true)
        expect(wrapper.find('.logo.vue').exists()).toBe(true)
    })
})

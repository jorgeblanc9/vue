import { describe, it, expect } from 'vitest'
import { mount } from '@vue/test-utils'
import HelloWorld from '../HelloWorld.vue'

describe('HelloWorld', () => {
    it('renders properly with default props', () => {
        const wrapper = mount(HelloWorld)

        expect(wrapper.exists()).toBe(true)
        expect(wrapper.find('h1').exists()).toBe(true)
    })

    it('renders with custom message prop', () => {
        const customMessage = 'Hello Test World'
        const wrapper = mount(HelloWorld, {
            props: { msg: customMessage }
        })

        expect(wrapper.text()).toContain(customMessage)
    })

    it('increments counter when button is clicked', async () => {
        const wrapper = mount(HelloWorld)

        const button = wrapper.find('button')
        expect(button.exists()).toBe(true)

        // Initial count should be 0
        expect(wrapper.text()).toContain('count is 0')

        // Click the button
        await button.trigger('click')

        // Count should be 1
        expect(wrapper.text()).toContain('count is 1')
    })

    it('has correct structure', () => {
        const wrapper = mount(HelloWorld)

        expect(wrapper.find('h1').exists()).toBe(true)
        expect(wrapper.find('.card').exists()).toBe(true)
        expect(wrapper.find('button').exists()).toBe(true)
        expect(wrapper.find('p').exists()).toBe(true)
    })

    it('contains expected links', () => {
        const wrapper = mount(HelloWorld)

        const links = wrapper.findAll('a')
        expect(links.length).toBeGreaterThan(0)

        // Check for create-vue link
        const createVueLink = links.find(link => link.text().includes('create-vue'))
        expect(createVueLink).toBeTruthy()
        expect(createVueLink.attributes('href')).toContain('vuejs.org')
    })
})

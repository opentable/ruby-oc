require 'spec_helper'

class TestRenderer # :nodoc:
  include OpenComponents::Renderer
end

RSpec.describe OpenComponents::Renderer do
  describe '#render_component' do
    before do
      stub_request(:get, "http://localhost:3030/foobar/1.0.1").
        with(query: {name: 'foobar'}).
        to_return(status: 200, body: '{"href":"http://localhost:3030/foobar/1.0.1?name=foobar","type":"oc-component-local","version":"1.0.1","requestVersion":"1.0.1","html":"<oc-component href=\"http://localhost:3030/foobar/1.0.1?name=foobar\" data-hash=\"0fe4b3fb2d6c0810f0d97a222a7e61eb91243bea\" id=\"8502960618\" data-rendered=\"true\" data-version=\"1.0.0\"><h1>ohai, my name is foobar</h1></oc-component>","renderMode":"rendered"}', headers: {})

      stub_request(:get, "http://localhost:3030/barfoo/").
        to_return(status: 404, body: "", headers: {})
    end

    let(:renderer) { TestRenderer.new }

    it 'returns the HTML for a component' do
      expect(renderer.render_component(
        'foobar', params: {name: 'foobar'}, version: '1.0.1'
      )).to eq "<oc-component href=\"http://localhost:3030/foobar/1.0.1?name=foobar\" data-hash=\"0fe4b3fb2d6c0810f0d97a222a7e61eb91243bea\" id=\"8502960618\" data-rendered=\"true\" data-version=\"1.0.0\"><h1>ohai, my name is foobar</h1></oc-component>"
    end

    it 'raises an error if the component is not found' do
      expect { renderer.render_component('barfoo') }
        .to raise_exception(OpenComponents::ComponentNotFound)
    end
  end
end

require 'spec_helper'

RSpec.describe OpenComponents::UnrenderedComponent do
  describe '#load' do
    context 'for the latest component version' do
      context 'with request params' do
        before do
          stub_request(:get, "http://localhost:3030/foobar/").
            with(
              headers: {'Accept'=>'application/vnd.oc.unrendered+json', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'},
              query: {name: 'foobar'}
            ).
            to_return(status: 200, body: '{"href":"http://localhost:3030/foobar?name=foobar","type":"oc-component-local","version":"1.0.0","requestVersion":"","data":{"name":"foobar"},"template":{"src":"http://localhost:3030/foobar/1.0.0/static/template.js","type":"jade","key":"0fe4b3fb2d6c0810f0d97a222a7e61eb91243bea"},"renderMode":"unrendered"}', headers: {})
        end

        subject { described_class.new('foobar', params: {name: 'foobar'}).load }

        it 'sets the component href' do
          expect(subject.href).to eq('http://localhost:3030/foobar?name=foobar')
        end

        it 'sets the component version' do
          expect(subject.registry_version).to eq('1.0.0')
        end

        it 'sets the component request version' do
          expect(subject.request_version).to be nil
        end

        it 'sets the component type' do
          expect(subject.type).to eq 'oc-component-local'
        end

        it 'sets the component render mode' do
          expect(subject.render_mode).to eq 'unrendered'
        end

        it 'sets the component data' do
          expect(subject.data).to eq({'name' => 'foobar'})
        end

        it 'sets the component template' do
          expect(subject.template).to eq OpenComponents::Template.new(
            'http://localhost:3030/foobar/1.0.0/static/template.js',
            'jade',
            '0fe4b3fb2d6c0810f0d97a222a7e61eb91243bea'
          )
        end
      end

      context 'without request params' do
        before do
          stub_request(:get, "http://localhost:3030/foobar/").
            with(
              headers: {'Accept'=>'application/vnd.oc.unrendered+json', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
            to_return(status: 200, body: '{"href":"http://localhost:3030/foobar","type":"oc-component-local","version":"1.0.0","requestVersion":"","data":{"name":"Todd"},"template":{"src":"http://localhost:3030/foobar/1.0.0/static/template.js","type":"jade","key":"0fe4b3fb2d6c0810f0d97a222a7e61eb91243bea"},"renderMode":"unrendered"}', headers: {})
        end

        subject { described_class.new('foobar').load }

        it 'sets the component href' do
          expect(subject.href).to eq('http://localhost:3030/foobar')
        end

        it 'sets the component version' do
          expect(subject.registry_version).to eq('1.0.0')
        end

        it 'sets the component request version' do
          expect(subject.request_version).to be nil
        end

        it 'sets the component type' do
          expect(subject.type).to eq 'oc-component-local'
        end

        it 'sets the component render mode' do
          expect(subject.render_mode).to eq 'unrendered'
        end

        it 'sets the component data' do
          expect(subject.data).to eq({'name' => 'Todd'})
        end

        it 'sets the component template' do
          expect(subject.template).to eq OpenComponents::Template.new(
            'http://localhost:3030/foobar/1.0.0/static/template.js',
            'jade',
            '0fe4b3fb2d6c0810f0d97a222a7e61eb91243bea'
          )
        end
      end
    end

    context 'for a specific component version' do
      context 'with request params' do
        before do
          stub_request(:get, "http://localhost:3030/foobar/1.0.0").
            with(
              headers: {'Accept'=>'application/vnd.oc.unrendered+json', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'},
              query: {name: 'foobar'}
            ).
            to_return(status: 200, body: '{"href":"http://localhost:3030/foobar/1.0.0?name=foobar","type":"oc-component-local","version":"1.0.0","requestVersion":"1.0.0","data":{"name":"foobar"},"template":{"src":"http://localhost:3030/foobar/1.0.0/static/template.js","type":"jade","key":"0fe4b3fb2d6c0810f0d97a222a7e61eb91243bea"},"renderMode":"unrendered"}', headers: {})
        end

        subject { described_class.new('foobar', params: {name: 'foobar'}, version: '1.0.0').load }

        it 'sets the component href' do
          expect(subject.href).to eq('http://localhost:3030/foobar/1.0.0?name=foobar')
        end

        it 'sets the component version' do
          expect(subject.version).to eq('1.0.0')
        end

        it 'sets the component request version' do
          expect(subject.request_version).to eq '1.0.0'
        end

        it 'sets the component type' do
          expect(subject.type).to eq 'oc-component-local'
        end

        it 'sets the component render mode' do
          expect(subject.render_mode).to eq 'unrendered'
        end

        it 'sets the component data' do
          expect(subject.data).to eq({'name' => 'foobar'})
        end

        it 'sets the component template' do
          expect(subject.template).to eq OpenComponents::Template.new(
            'http://localhost:3030/foobar/1.0.0/static/template.js',
            'jade',
            '0fe4b3fb2d6c0810f0d97a222a7e61eb91243bea'
          )
        end
      end

      context 'without request params' do
        before do
          stub_request(:get, "http://localhost:3030/foobar/1.0.0").
            with(
              headers: {'Accept'=>'application/vnd.oc.unrendered+json', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
            to_return(status: 200, body: '{"href":"http://localhost:3030/foobar/1.0.0","type":"oc-component-local","version":"1.0.0","requestVersion":"1.0.0","data":{"name":"Todd"},"template":{"src":"http://localhost:3030/foobar/1.0.0/static/template.js","type":"jade","key":"0fe4b3fb2d6c0810f0d97a222a7e61eb91243bea"},"renderMode":"unrendered"}', headers: {})
        end

        subject { described_class.new('foobar', version: '1.0.0').load }

        it 'sets the component href' do
          expect(subject.href).to eq('http://localhost:3030/foobar/1.0.0')
        end

        it 'sets the component version' do
          expect(subject.version).to eq('1.0.0')
        end

        it 'sets the component request version' do
          expect(subject.request_version).to eq '1.0.0'
        end

        it 'sets the component type' do
          expect(subject.type).to eq 'oc-component-local'
        end

        it 'sets the component render mode' do
          expect(subject.render_mode).to eq 'unrendered'
        end

        it 'sets the component data' do
          expect(subject.data).to eq({'name' => 'Todd'})
        end

        it 'sets the component template' do
          expect(subject.template).to eq OpenComponents::Template.new(
            'http://localhost:3030/foobar/1.0.0/static/template.js',
            'jade',
            '0fe4b3fb2d6c0810f0d97a222a7e61eb91243bea'
          )
        end
      end
    end

    context 'for a missing component' do
      before do
        stub_request(:get, "http://localhost:3030/foo/").
          with(headers: {'Accept'=>'application/vnd.oc.unrendered+json', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'}).
          to_return(status: 404, body: "", headers: {})
      end

      subject { described_class.new('foo').load }

      it 'raises an exception' do
        expect { subject }.to raise_exception(OpenComponents::ComponentNotFound)
      end
    end

    context 'for a registry timeout' do
      before do
        stub_request(:get, "http://localhost:3030/foo/").to_timeout
      end

      subject { described_class.new('foo').load }

      it 'raises an exception' do
        expect { subject }.to raise_exception(OpenComponents::RegistryTimeout)
      end
    end

    context 'with custom HTTP headers' do
      let!(:stub) do
        stub_request(:get, "http://localhost:3030/foobar/").
          with(:headers => {'Accept'=>'application/vnd.oc.unrendered+json', 'Accept-Encoding'=>'gzip, deflate', 'Accept-Language'=>'emoji', 'User-Agent'=>'Ruby'}).
          to_return(:status => 200, :body => '{"href":"http://localhost:3030/foobar/1.0.0","type":"oc-component-local","version":"1.0.0","requestVersion":"","data":{"name":"Todd"},"template":{"src":"http://localhost:3030/foobar/1.0.0/static/template.js","type":"jade","key":"0fe4b3fb2d6c0810f0d97a222a7e61eb91243bea"},"renderMode":"unrendered"}', :headers => {})
      end

      subject { described_class.new('foobar', headers: {accept_language: 'emoji'}).load }

      it 'includes custom headers in the request' do
        subject
        expect(stub).to have_been_requested
      end
    end
  end

  describe '#flush!' do
    let(:component) { described_class.new('foobar', params: {name: 'foobar'}, version: '1.0.1') }
    let(:template)  { OpenComponents::Template.new('foo', 'bar', 'baz') }

    before do
      component.instance_variable_set(:@href, 'http://foo.com/bar/1.0.1')
      component.instance_variable_set(:@registry_version, '1.0.1')
      component.instance_variable_set(:@request_version, '1.0.1')
      component.instance_variable_set(:@type, 'some-oc-type')
      component.instance_variable_set(:@render_mode, 'rendered')
      component.instance_variable_set(:@data, {'name' => 'foobar'})
      component.instance_variable_set(:@template, template)
    end

    it 'does not modify name' do
      component.flush!
      expect(component.name).to eq 'foobar'
    end

    it 'does not modify params' do
      component.flush!
      expect(component.params).to eq({name: 'foobar'})
    end

    it 'does not modify version' do
      component.flush!
      expect(component.version).to eq '1.0.1'
    end

    it 'sets all allowed values to nil' do
      component.flush!

      expect(component.href).to_not eq 'http://foo.com/bar/1.0.1'
      expect(component.registry_version).to_not eq '1.0.1'
      expect(component.request_version).to_not eq '1.0.1'
      expect(component.type).to_not eq 'some-oc-type'
      expect(component.render_mode).to_not eq 'rendered'
      expect(component.data).to_not eq({'name' => 'foobar'})
      expect(component.template).to_not eq template
    end

    it 'returns self' do
      expect(component.flush!).to eq component
    end
  end

  describe '#reload!' do
    let(:component) { described_class.new('foobar', params: {name: 'foobar'}) }

    before do
        stub_request(:get, "http://localhost:3030/foobar/").
          with(
            headers: {'Accept'=>'application/vnd.oc.unrendered+json', 'Accept-Encoding'=>'gzip, deflate', 'User-Agent'=>'Ruby'},
            query: {name: 'foobar'}
          ).
          to_return(status: 200, body: '{"href":"http://foo.com/bar?name=foobar","type":"some-oc-type","version":"1.0.2","requestVersion":"","data":{"name":"foobar"},"template":{"src":"http://foo.com/bar/1.0.2/static/template.js","type":"jade","key":"0fe4b3fb2d6c0810f0d97a222a7e61eb91243bea"},"renderMode":"unrendered"}', headers: {})

      component.instance_variable_set(:@href, 'http://foo.com/bar/1.0.1')
      component.instance_variable_set(:@registry_version, '1.0.1')
      component.instance_variable_set(:@request_version, '')
      component.instance_variable_set(:@type, 'some-oc-type')
      component.instance_variable_set(:@render_mode, 'unrendered')
      component.instance_variable_set(:@data, {'name' => 'foobar'})
      component.instance_variable_set(:@template, OpenComponents::Template.new('foo', 'bar', 'baz'))
    end

    it 'reloads the component and sets the correct values' do
      component.reload!

      expect(component.href).to eq 'http://foo.com/bar?name=foobar'
      expect(component.registry_version).to eq '1.0.2'
      expect(component.request_version).to be nil
      expect(component.type).to eq 'some-oc-type'
      expect(component.render_mode).to eq 'unrendered'
      expect(component.data).to eq({'name' => 'foobar'})
      expect(component.template).to eq OpenComponents::Template.new(
        'http://foo.com/bar/1.0.2/static/template.js',
        'jade',
        '0fe4b3fb2d6c0810f0d97a222a7e61eb91243bea'
      )
    end
  end
end

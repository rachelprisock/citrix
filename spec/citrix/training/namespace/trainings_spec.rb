require 'spec_helper'

describe Citrix::Training::Namespace::Trainings do
  describe '#create' do
    let(:client) { build_client }

    it 'performs request' do
      stub_request(:post, /.+/)

      url = url_for('organizers', client.credentials.organizer_key, 'trainings')
      attrs = build_training_attributes
      serialized_attrs = serialize(attrs, Citrix::Training::Serializer::Training)
      client.trainings.create(attrs)

      expect(last_request.method).to eq(:post)
      expect(last_request.uri.normalize.to_s).to eq(url)
      expect(last_request.body).to eq(JSON.dump(serialized_attrs))
    end

    it 'returns response' do
      stub_request(:post, /.+/)
      response, training = client.trainings.create({})
      expect(response).to be_a(Aitch::Response)
    end

    it 'returns training instance' do
      stub_request(:post, /.+/)
      response, training = client.trainings.create({})
      expect(training).to be_a(Citrix::Training::Resource::Training)
    end

    it 'sets training key' do
      stub_request(:post, /.+/).to_return(body: '"1234"', status: 201)
      response, training = client.trainings.create({})
      expect(training.key).to eq('1234')
    end
  end

  describe '#all' do
    let(:client) { build_client }

    it 'performs request' do
      stub_request(:get, /.+/).to_return(body: '[]', headers: {'Content-Type' => 'application/json'})

      url = url_for('organizers', client.credentials.organizer_key, 'trainings')
      client.trainings.all

      expect(last_request.method).to eq(:get)
      expect(last_request.uri.normalize.to_s).to eq(url)
    end

    it 'returns trainings' do
      stub_request(:get, /.+/)
        .to_return(status: 200, body: fixtures.join('trainings.json').read, headers: {'Content-Type' => 'application/json'})

      response, trainings = client.trainings.all

      expect(trainings.size).to eq(1)
      expect(trainings.first).to be_a(Citrix::Training::Resource::Training)
    end
  end

  describe '#find' do
    let(:client) { build_client }

    it 'performs request' do
      stub_request(:get, /.+/)
        .to_return(status: 200, body: fixtures.join('training.json').read, headers: {'Content-Type' => 'application/json'})
      client.trainings.find('1234')

      url = url_for('organizers', client.credentials.organizer_key, 'trainings', '1234')

      expect(last_request.method).to eq(:get)
      expect(last_request.uri.normalize.to_s).to eq(url)
    end

    it 'returns training' do
      stub_request(:get, /.+/)
        .to_return(status: 200, body: fixtures.join('training.json').read, headers: {'Content-Type' => 'application/json'})

      response, training = client.trainings.find('1234')

      expect(training).to be_a(Citrix::Training::Resource::Training)
    end
  end

  describe '#remove' do
    let(:client) { build_client }

    it 'performs request' do
      stub_request(:delete, /.+/)

      training = build_training
      url = url_for('organizers', client.credentials.organizer_key, 'trainings', training.key)
      client.trainings.remove(training)

      expect(last_request.method).to eq(:delete)
      expect(last_request.uri.normalize.to_s).to eq(url)
    end

    it 'returns response' do
      stub_request(:delete, /.+/)
      training = build_training
      response = client.trainings.remove(training)

      expect(response).to be_a(Aitch::Response)
    end
  end
end

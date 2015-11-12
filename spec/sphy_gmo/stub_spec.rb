require 'spec_helper'

describe SphyGmo::Stub do
  let(:configs) { {
      host: 'host',
      site_id: '123456789',
      site_pass: 'secret',
      shop_id: '987654321',
      shop_pass: 'opensesame'
    } }
  before do
    SphyGmo.configure do |config|
      configs.each_pair { |k,v| config.send("#{k}=", v) }
    end
  end

  describe '.modes' do
    subject { SphyGmo::Stub.modes }

    it { is_expected.to eq [:disable] }

    describe '.mode=' do
      context 'with enable' do
        it {
          SphyGmo::Stub.mode = :enable
          expect(subject).to eq [:enable]
        }
      end
      context 'with disable' do
        it {
          SphyGmo::Stub.mode = :disable
          expect(subject).to eq [:disable]
        }
      end
    end

    describe '.stub' do
      context 'with enable' do
        context 'inner block' do
          it {
            SphyGmo::Stub.stub :enable do
              expect(subject).to eq [:disable, :enable]
            end
          }
        end
        context 'after block' do
          it {
            SphyGmo::Stub.stub :enable do; end
            expect(subject).to eq [:disable]
          }
        end
      end

      context 'with disable' do
        context 'inner block' do
          it {
            SphyGmo::Stub.stub :disable do
              expect(subject).to eq [:disable, :disable]
            end
          }
        end
        context 'after block' do
          it {
            SphyGmo::Stub.stub :enable do; end
            expect(subject).to eq [:disable]
          }
        end
      end
    end
  end


  describe 'stubbing' do
    subject { SphyGmo::Member.search!(member_id: '1') }

    shared_examples_for 'a regular mode' do
      # connecting to SphyGmo.configuration.host is causing to fail with SocketError
      it { expect{subject}.to raise_error(SocketError) }
    end

    shared_examples_for 'a stubbed mode' do
      it('connection is success') { expect{subject}.not_to raise_error }
      it('response is blank hash') { is_expected.to eq({}) }
    end


    describe '.mode=' do
      context 'with enable' do
        it_behaves_like 'a stubbed mode' do
          before { SphyGmo::Stub.mode = :enable }
        end
      end
      context 'with disable' do
        it_behaves_like 'a regular mode' do
          before { SphyGmo::Stub.mode = :disable }
        end
      end
    end

    describe '.stub' do
      context 'with enable' do
        context 'inner block' do
          it_behaves_like 'a stubbed mode' do
            around do |ex|
              SphyGmo::Stub.stub :enable do
                ex.run
              end
            end
          end
        end
        context 'after block' do
          it_behaves_like 'a regular mode' do
            before { SphyGmo::Stub.stub :enable do; end }
          end
        end
      end

      context 'with disable' do
        context 'inner block' do
          it_behaves_like 'a regular mode' do
            around do |ex|
              SphyGmo::Stub.stub :disable do
                ex.run
              end
            end
          end
        end
        context 'after block' do
          it_behaves_like 'a regular mode' do
            before { SphyGmo::Stub.stub :disable do; end }
          end
        end
      end
    end
  end
end

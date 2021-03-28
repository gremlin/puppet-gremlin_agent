# frozen_string_literal: true

require 'spec_helper'

describe 'gremlin_agent' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:params) do
        {
          'gremlin_team_id' => '11111111-1111-1111-1111-111111111111',
          'gremlin_team_secret' => '11111111-1111-1111-1111-111111111111',
        }
      end

      it { is_expected.to compile }
    end
  end
end

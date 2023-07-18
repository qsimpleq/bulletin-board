# frozen_string_literal: true

json.array! @bulletins, partial: 'bulletins/bulletin', as: :bulletin

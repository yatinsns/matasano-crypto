require_relative "../challenge1/conversion.rb"
require_relative "../challenge3/string_additions.rb"

require_relative "./matrix_aes_additions.rb"
require_relative "./matrix_operations.rb"

include Matrix

module AES
  def self.block_cipher_encryption(state_matrix_128, cipher_matrix_128)
    round_ciphers = cipher_matrix_128.get_round_ciphers

    # begin
    round = 0
    state_matrix_128.add_round_key round_ciphers[round]

    # middle
    9.times do |turn|
      round += 1
      state_matrix_128.substitute
      state_matrix_128.shift_row
      state_matrix_128.mix_columns
      state_matrix_128.add_round_key round_ciphers[round]
    end

    # end
    round += 1
    state_matrix_128.substitute
    state_matrix_128.shift_row
    state_matrix_128.add_round_key round_ciphers[round]

    state_matrix_128 
  end

  def self.block_cipher_decryption(state_matrix_128, cipher_matrix_128)
    round_ciphers = cipher_matrix_128.get_round_ciphers

    # begin
    round = 10
    state_matrix_128.add_round_key round_ciphers[round]

    # middle
    9.times do |turn|
      round -= 1

      state_matrix_128.inverse_shift_row
      state_matrix_128.inverse_substitute
      state_matrix_128.add_round_key round_ciphers[round]
      state_matrix_128.inverse_mix_columns
    end

    # end
    round -= 1
    state_matrix_128.inverse_shift_row
    state_matrix_128.inverse_substitute
    state_matrix_128.add_round_key round_ciphers[round]

    state_matrix_128
  end
end

require_relative "./single_byte_xor.rb"

describe "Single byte XOR" do
  it "should print probable keys" do
    print_probable_single_byte_xor_keys_for_cipher("1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736")
    # Vague test: Testing nothing (Should have created the rake task)
  end
end

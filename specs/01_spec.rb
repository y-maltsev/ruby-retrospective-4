describe "series" do
  it "handles fibonacci series for base cases" do
    expect(series('fibonacci', 1)).to eq 1
    expect(series('fibonacci', 2)).to eq 1
  end

  it "handles fibonacci series for odd numbers" do
    expect(series('fibonacci', 7)).to eq 13
    expect(series('fibonacci', 9)).to eq 34
  end

  it "handles fibonacci series for even numbers" do
    expect(series('fibonacci', 8)).to eq 21
    expect(series('fibonacci', 10)).to eq 55
  end

  it "handles fibonacci series for bigger numbers" do
    expect(series('fibonacci', 15)).to eq 610
    expect(series('fibonacci', 20)).to eq 6765
  end

  it "handles lucas series for base cases" do
    expect(series('lucas', 1)).to eq 2
    expect(series('lucas', 2)).to eq 1
  end

  it "handles lucas series for odd numbers" do
    expect(series('lucas', 7)).to eq 18
    expect(series('lucas', 9)).to eq 47
  end

  it "handles lucas series for even numbers" do
    expect(series('lucas', 8)).to eq 29
    expect(series('lucas', 10)).to eq 76
  end

  it "handles lucas series for bigger numbers" do
    expect(series('lucas', 15)).to eq 843
    expect(series('lucas', 20)).to eq 9349
  end

  it "handles summed series for base cases" do
    expect(series('summed', 1)).to eq 3
    expect(series('summed', 2)).to eq 2
  end

  it "handles summed series for odd numbers" do
    expect(series('summed', 7)).to eq 31
    expect(series('summed', 9)).to eq 81
  end

  it "handles summed series for even numbers" do
    expect(series('summed', 8)).to eq 50
    expect(series('summed', 10)).to eq 131
  end

  it "handles summed series for bigger numbers" do
    expect(series('summed', 15)).to eq 1453
    expect(series('summed', 20)).to eq 16114
  end
end

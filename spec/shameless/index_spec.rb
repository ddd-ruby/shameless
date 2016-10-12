describe Shameless::Index do
  it 'allows querying by a named index' do
    store, model = build_store do |store|
      Store = store

      class MyModel
        Store.attach(self)

        index :foo do
          integer :my_id
          shard_on :my_id
        end
      end
    end

    MyModel.put(my_id: 1, foo: 'bar')

    instance = MyModel.foo_index.where(my_id: 1).first

    expect(instance[:foo]).to eq('bar')

    Object.send(:remove_const, :MyModel)
    Object.send(:remove_const, :Store)
  end
end

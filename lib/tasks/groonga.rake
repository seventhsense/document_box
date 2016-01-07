require_relative '../../config/environment'
namespace :groonga do
  desc "Create groonga database"
  task :create => :environment do
    Groonga::Schema.define do |schema|
      schema.create_table(
        'Documents',
        type: :hash,
        key_type: :uint32
      ) do |table|
        table.short_text('name')
        table.short_text('author')
        table.text('content')
        table.time('date')
        table.short_text('label')
        table.text('body')
        table.time('created_at')
        table.time('updated_at')
      end
    end
    Groonga::Schema.define do |schema|
      schema.create_table(
        'Terms',
        type: :patricia_trie,
        key_type: :short_text,
        normalizer: 'NormalizerAuto',
        default_tokenizer: 'TokenBigram'
      ) do |table|
        table.index('Documents.name')
        table.index('Documents.author')
        table.index('Documents.content')
        table.index('Documents.label')
        table.index('Documents.body')
      end
      schema.create_table(
        'Times',
        type: :patricia_trie,
        key_type: :time
      ) do |table|
        table.index('Documents.created_at')
        table.index('Documents.updated_at')
        table.index('Documents.date')
      end
    end
    puts 'database created'
  end
end

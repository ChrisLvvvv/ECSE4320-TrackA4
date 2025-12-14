#pragma once
#include "hashtable.h"
#include <vector>
#include <mutex>

namespace a4 {

// Placeholder for the second strategy.
// We'll implement lock striping next.
class HashTableStriped final : public IHashTable {
 public:
  HashTableStriped(std::size_t buckets, std::size_t stripes);
  Status insert(Key k, const Value& v) override;
  Status find(Key k, Value* out) const override;
  Status erase(Key k) override;
  std::size_t size() const override;

 private:
  std::size_t buckets_;
  std::size_t stripes_;
};

} // namespace a4

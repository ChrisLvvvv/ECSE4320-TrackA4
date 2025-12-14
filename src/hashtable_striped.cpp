#include "hashtable_striped.h"

namespace a4 {

HashTableStriped::HashTableStriped(std::size_t buckets, std::size_t stripes)
    : buckets_(buckets), stripes_(stripes) {}

Status HashTableStriped::insert(Key, const Value&) { return Status::kNotFound; }
Status HashTableStriped::find(Key, Value*) const { return Status::kNotFound; }
Status HashTableStriped::erase(Key) { return Status::kNotFound; }
std::size_t HashTableStriped::size() const { return 0; }

} // namespace a4

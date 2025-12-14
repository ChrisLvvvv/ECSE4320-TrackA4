#include "config.h"
#include "hashtable_coarse.h"
#include "hashtable_striped.h"
#include <iostream>

static a4::Value make_value(std::uint64_t x) {
  a4::Value v{};
  for (std::size_t i = 0; i < v.size(); ++i) {
    v[i] = static_cast<std::uint8_t>((x >> (i * 8)) & 0xFF);
  }
  return v;
}

static void sanity(a4::IHashTable& ht) {
  const auto v = make_value(0x1122334455667788ULL);
  std::cout << "insert: " << static_cast<int>(ht.insert(42, v)) << "\n";

  a4::Value out{};
  std::cout << "find: " << static_cast<int>(ht.find(42, &out)) << "\n";
  std::cout << "erase: " << static_cast<int>(ht.erase(42)) << "\n";
  std::cout << "find_after: " << static_cast<int>(ht.find(42, &out)) << "\n";
  std::cout << "size: " << ht.size() << "\n";
}

int main() {
  std::cout << "[coarse]\n";
  a4::HashTableCoarse coarse(a4::kDefaultBuckets);
  sanity(coarse);

  std::cout << "\n[striped]\n";
  a4::HashTableStriped striped(a4::kDefaultBuckets, a4::kDefaultStripes);
  sanity(striped);

  return 0;
}

import "@typespec/http";

namespace Pets;

model Pet {
  id: int32;
  name: string;
  tag?: string;

  @minValue(0)
  @maxValue(20)
  age: int32;

  ownerId: int64;
  availableSince: utcDateTime;
  size: "big" | "small";
  image: bytes;
}

@error
model Error {
  code: int32;
  message: string;
}
import "@typespec/http";

namespace Pets;

model Pet {
  id: string;
  name: string;
  tag?: string;

  @minValue(0)
  @maxValue(20)
  age: int32;

  ownerId: int64;
  availableSince: utcDateTime;
  size: "big" | "small";
  image?: bytes;
}

model Provider {
  id: string;
  name: string;
  address: string;
}

model InsurancePolicy {
  id: string;
  petId: string;
  providerId: string;
  premium: int32;
  deductible: int32;
}

model InsuranceClaim {
  id: string;
  policyId: string;

  @minValue(0)
  loss: float;
}

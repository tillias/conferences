import "@typespec/http";
import "./versions.tsp";

using TypeSpec.Versioning;

namespace Pets;

// Inheritance example

model EntityBase<T> {
  id: T;
}

@friendlyName("nameable")
model NameableEntity<T> extends EntityBase<T> {
  name: string;
}

model Pet extends NameableEntity<string> {
  tag?: string;

  @minValue(0)
  @maxValue(20)
  @removed(Versions.v2)
  age: int32;

  @added(Versions.v2)
  @removed(Versions.v3)
  dateOfBirth: plainDate;

  @added(Versions.v3)
  birthday: plainDate;

  @madeOptional(Versions.v2)
  ownerId?: int64;

  availableSince: utcDateTime;
  size: "big" | "small";
  image?: bytes;
}

model Provider extends NameableEntity<string> {
  address: string;
}

// Spreading example

model Metadata {
  createdBy: string;
  createdOn: utcDateTime;
  modifiedOn: utcDateTime;
}

model InsurancePolicy extends EntityBase<string> {
  petId: string;
  providerId: string;
  premium: int32;
  deductible: int32;

  ...Metadata;
}

model InsuranceClaim extends EntityBase<string> {
  policyId: string;

  @minValue(0)
  loss: float;

  ...Metadata;
}

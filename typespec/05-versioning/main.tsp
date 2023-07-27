import "@typespec/http";
import "./model.tsp";
import "./library.tsp";
import "./versions.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using CloudApiLib;

@service({
  title: "Pet Store Service"
})
@server("https://example.com", "Single server endpoint")
@useAuth(BearerAuth)
@versioned(Versions)
namespace Pets;

@route("/pets")
@tag("pet")
interface PetStore extends BaseOperations<Pet> {

  @route(":search")
  @removed(Versions.v2)
  search is postAction<List<Pet>, {@body searchString: string}>;
}

@route("/insurance")
@tag("insurance")
interface PetInsurance extends BaseOperations<InsurancePolicy> {}

@route("/claims")
@tag("claim")
interface PetInsuranceClaims extends BaseOperations<InsuranceClaim> {

  @route(":search")
  @added(Versions.v2)
  @removed(Versions.v3)
  searchAllClaims is postAction<List<InsuranceClaim>, {@body petId: string}>;
}

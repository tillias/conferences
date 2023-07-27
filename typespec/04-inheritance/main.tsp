import "@typespec/http";
import "@typespec/versioning";
import "./model.tsp";
import "./library.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using CloudApiLib;

@service({
  title: "Pet Store Service"
})
@server("https://example.com", "Single server endpoint")
@useAuth(BearerAuth)
namespace Pets;

@route("/pets")
@tag("pet")
interface PetStore extends BaseOperations<Pet> {

  @route(":search")
  search is postAction<List<Pet>, {@body searchString: string}>;
}

@route("/insurance")
@tag("insurance")
interface PetInsurance extends BaseOperations<InsurancePolicy> {}

@route("/claims")
@tag("claim")
interface PetInsuranceClaims extends BaseOperations<InsuranceClaim> {

  @route(":search")
  searchAllClaims is postAction<List<InsuranceClaim>, {@body petId: string}>;
}

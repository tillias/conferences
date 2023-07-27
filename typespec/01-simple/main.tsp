import "@typespec/http";

using TypeSpec.Http;

@service({
  title: "Pet Store Service",
  version: "2021-03-25",
})
namespace Pets {

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
  }

  @error
  model Error {
    code: int32;
    message: string;
  }

  @route("/pets")
  interface PetStore {
      @get list(): Pet[] | Error;
      @get read(@path id: int32): Pet | Error;
      @post create(...Pet): Pet | Error;
      @patch update(...Pet): Pet | Error;
      @delete delete(@path id: int32): void | Error;
  }
}





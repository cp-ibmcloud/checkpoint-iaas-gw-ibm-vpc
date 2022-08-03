locals { 
  image_map = {

    R8110-Management = {
      "us-south" = "r006-36621bb0-a1dd-4392-8ece-12119ef1ad99"
      "us-east"  = "r014-651997d5-f3f4-4e8a-bbdd-41e2be249eb9"
      "eu-gb"    = "r018-0332aee8-d700-4a9e-a5cf-53d26e2eb862"
      "eu-de"    = "r010-3bb47978-0dd7-488f-bb10-280b0e3ab894"
      "jp-tok"   = "r022-89766fa2-5db2-4743-bdcc-d66410c7c9cd"
      "jp-osa"   = "r034-07ff27e7-c228-4f7e-b0cc-07b03fd6833d"
      "au-syd"   = "r026-f34aa81d-3ea5-4408-93f0-559d4fa30b86"
      "ca-tor"   = "r038-72ab080a-5651-4da5-a98b-9ce3dc5336a4"
      "br-sao"   = "r042-c22bac22-1dfe-46ea-9618-6ce0900014a2"
    }

    R8110-Gateway = {
      "us-south" = "r006-6979547b-695e-4d40-b5eb-b6bd17760b8e"
      "us-east"  = "r014-ec547f98-7630-4b5d-825f-8d67e0fae8ef"
      "eu-gb"    = "r018-81ac1f10-127d-4e9b-b848-c3728812b388"
      "eu-de"    = "r010-1289cb71-a517-4754-b64a-17963255bde4"
      "jp-tok"   = "r022-81b69e3c-7f2d-4035-a4a5-f13a85eaa086"
      "jp-osa"   = "r034-152f7c8e-d18d-4927-924f-2cd8c0a17589"
      "au-syd"   = "r026-31a5b5b1-f5d1-4f3b-b6d1-9ec01e3b43ba"
      "ca-tor"   = "r038-c00c2f89-bcec-4613-9e29-24edbce133ac"
      "br-sao"   = "r042-e7c73187-24b0-47a0-bb5c-2186fea7bfee"
    }

    R81-Management = {
      "us-south" = "r006-0ba8b686-102a-4136-a672-fd9c019d8e4d"
      "us-east"  = "r014-a6ced65c-4ecf-48ce-945b-703421bf5e9f"
      "eu-gb"    = "r018-77dc3753-087e-4c64-a125-26ba42cc8e1a"
      "eu-de"    = "r010-2e3e68f0-c27e-407a-86cb-317dd4e8d477"
      "jp-tok"   = "r022-fd236773-fb50-4b60-a28b-3f088ce108bb"
      "jp-osa"   = "r034-52ed7d2a-7b13-44d2-92d1-6e920936300b"
      "au-syd"   = "r026-af13d0cf-9479-44b9-b964-b9e81e9e3292"
      "ca-tor"   = "r038-ad9540ee-2532-4565-a6a3-ef6fa5d50f60"
      "br-sao"   = "r042-c5092fd1-732a-40b9-9cd8-ba8127461442"
    }

    R81-Gateway = {
      "us-south" = "r006-c9fddc89-b6c2-4265-bc38-6688b295fe21"
      "us-east"  = "r014-0d74aee7-174f-4a12-8dca-7321d4d66124"
      "eu-gb"    = "r018-e7736f8f-a97c-43c5-814a-7447f2122b2d"
      "eu-de"    = "r010-ea9076ef-57cf-4bc9-a719-1ebfca308690"
      "jp-tok"   = "r022-f6a8142f-697a-418d-9a0f-5d40168f571d"
      "jp-osa"   = "r034-7b452e66-37b2-4e0b-89c8-f1f3ddfe9a86"
      "au-syd"   = "r026-9bfdc497-1510-4ccd-b515-380fde4bad8f"
      "ca-tor"   = "r038-42f68e96-1b4b-46de-bf7a-96eff093c091"
      "br-sao"   = "r042-821bb30e-b93a-4e14-9610-18e48315b4aa"
    }

    R8040-Management = {
      "us-south" = "r006-72d57e38-bbc5-4ea2-8cb4-33d1d5e56ec2"
      "us-east"  = "r014-b1b9fc27-3c24-4587-aaeb-62417977235b"
      "eu-gb"    = "r018-6714cfd5-f97d-4b75-a395-5da3be1d4408"
      "eu-de"    = "r010-ca5214bd-077b-4ce1-b9f0-5ebfd8b05a5b"
      "jp-tok"   = "r022-5233b692-8a63-4fcd-8330-e097d28eb5f8"
      "jp-osa"   = "r034-446d5260-914c-45ee-96e5-4c57c09a36a6"
      "au-syd"   = "r026-81990067-3a7a-4ca4-b1b5-b5359bb0ab7b"
      "ca-tor"   = "r038-4d28debc-86b4-49be-b808-d1caad82d704"
      "br-sao"   = "r042-64a9a5c4-9a53-49ff-8be0-a0d1f055e1b3"
    }

    R8040-Gateway = {
      "us-south" = "r006-30e08d24-3870-4e8c-a563-cb3e8f2952d4"
      "us-east"  = "r014-ca2e129c-0acb-48dd-91de-b56e464c4b1f"
      "eu-gb"    = "r018-518a2921-3ace-41d3-935f-0e668aaaf411"
      "eu-de"    = "r010-ebb2362c-c7d2-413c-9ec4-a6a167039cb0"
      "jp-tok"   = "r022-e73e16e5-d0b9-4915-8313-0fa2d81877ef"
      "jp-osa"   = "r034-1aa8cb44-94f2-4340-8d26-a214a85153b9"
      "au-syd"   = "r026-19454a24-b275-470d-851e-f39a69aec583"
      "ca-tor"   = "r038-18114241-3fbf-4ca9-bd46-676564ba3e85"
      "br-sao"   = "r042-424e50a1-b8c1-4a9b-bc9d-267f6ac6eb6d"
    }

  }
}

## Moya - Networking Library

- Moya 라이브러리는 URLSession, Alamofire를 한번 더 감싼 통신 API 
- 열거형(enum)을 사용하여 네트워크 요청을 타입 안전(type-safe)한 방식으로 캡슐화하는데 초점을 맞춘 네트워킹 라이브러리

✅ **타입 안전(type-safe)한 방식?** 스위프트는 Type Safety Language ! ( 쉽게 말하면 String 타입의 변수에는 String 타입만 저장 가능 )

✅ **추상화 ?** 객체 지향 프로그래밍의 특징(추상화, 캡슐화, 은닉화, 상속성, 다형성) 중 하나로 객체들의 공통적인 부분을 뽑아내서 따로 구현해놓은 것

### 1. 세미나에서 사용했던 Alamofire와 차이점 ? 

- Alamofire에서는 네트워킹 역할을 도맡아 하는 에드혹 네트워크 추상화 층을 만들어 이 층에서 Alamofire 라이브러리를 호출하여 통신
- 하지만 이 네트워크 층은 통신에 관해서 완전히 추상화해주지 않음. URLs, parameters 등등
- 이러한 애드혹 네트워크층을 대신하고 Alamofire로 바로 연결해주는 네트워크 추상화층이 Moya ! ! 
 
<img src="https://user-images.githubusercontent.com/81313960/142769029-126938e3-b0d1-484d-8ce9-a3d4fa4dc849.png" width= "600">

- Moya는 오른쪽 그림처럼 깔끔한 레이어를 가지며 자체적으로 네트워킹을 수행하지 않고 Alamofire를 통해서 수행
- Network Layer를 템플릿화 시켜서 재사용할 수 있게 만들어준다는 점이 장점 !

### 2. Moya's Building Blocks

📌 Provider

: 모든 네트워크 서비스와 상호작용할때 만들고 사용할 주요한 객체, 초기화할때 Moya Target을 가지는 일반적인 객체

📌 Target

: 일반적으로 전체 API 서비스를 설명! 이 경우에는, Marvel target과 Imgur target이 있습니다. 그들 각 타겟은 서비스, 그 자체의 가능한 끝점, 요청을 이행하는 각 끝점에 요구되는 정보를 설명합니다. TargetType 프로토콜을 체택하는 것으로 target을 정의합니다.

[🔗 Target - github](https://github.com/Moya/Moya/blob/master/docs/Targets.md)

📌 Endpoint

: API란 두 시스템, 어플리케이션이 상호작용할 수 있게 하는 프로토콜의 총 집합이라면 Endpoint란 API가 서버에서 리소스에 접근 가능하게 하는 URL , 메소드(GET 등)는 같은 URL들에 대해서도 다른 요청을 하게끔 구별하게 해주는 항목



 




[🔗 Moya Library - github](https://github.com/Moya/Moya)

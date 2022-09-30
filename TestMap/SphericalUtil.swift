//
//  SphericalUtil.swift
//  TestMap
//
//  Created by admin on 30.09.2022.
//

import Foundation

public class SphericalUtil {
  
  private init()
  {
  }
  
  /**
  * Returns the LatLng resulting from moving a distance from an origin
  * in the specified heading (expressed in degrees clockwise from north).
  * @param from     The from : LatLng which to start.
  * @param distance The distance to travel.
  * @param heading  The heading in degrees clockwise from north.
  */
    class func computeOffset(from: Coordinate, distance: Double, heading: Double) -> Coordinate {
        var distanceNew = distance / MathUtil.EARTH_RADIUS
        var heading = MapUtils.toRadians(degrees: heading)
        let fromLat = MapUtils.toRadians(degrees: from.latitude)
        let fromLng = MapUtils.toRadians(degrees: from.longitude)
        let cosDistance = cos(distanceNew)
        let sinDistance = sin(distanceNew)
        let sinFromLat = sin(fromLat)
        let cosFromLat = cos(fromLat)
        let sinLat = cosDistance * sinFromLat + sinDistance * cosFromLat * cos(heading)
        let dLng = atan2(
            sinDistance * cosFromLat * sin(heading),
            cosDistance - sinFromLat * sinLat)
        return Coordinate(latitude: MapUtils.toDegrees(radians: asin(sinLat)), longitude: MapUtils.toDegrees(radians: fromLng + dLng))
    }
  
}

//
//class func computeOffset(from : LatLng, var distance : Double, var heading : Double) -> LatLng
//  {
//    distance /= MathUtil.EARTH_RADIUS
//    heading = MapUtils.toRadians(heading)
//    // http://williams.best.vwh.net/avform.htm#LL
//    let fromLat = MapUtils.toRadians(from.latitude)
//    let fromLng = MapUtils.toRadians(from.longitude)
//    let cosDistance = cos(distance)
//    let sinDistance = sin(distance)
//    let sinFromLat = sin(fromLat)
//    let cosFromLat = cos(fromLat)
//    let sinLat = cosDistance * sinFromLat + sinDistance * cosFromLat * cos(heading)
//    let dLng = atan2(
//      sinDistance * cosFromLat * sin(heading),
//      cosDistance - sinFromLat * sinLat)
//    return LatLng(latitude: MapUtils.toDegrees(asin(sinLat)), longitude: MapUtils.toDegrees(fromLng + dLng))
//  }
